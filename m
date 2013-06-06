From: Elliott Cable <me@ell.io>
Subject: Re: [PATCH/RFC] add --authorship-order flag to git log / rev-list
Date: Thu, 6 Jun 2013 14:06:39 -0400
Message-ID: <CAPZ477O2mRCi3gUE+Qoa8Vig2Z2Q5cUzRS0+KEZK3zufmOceig@mail.gmail.com>
References: <1370369299-20744-1-git-send-email-me@ell.io>
	<7vmwr57lo1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 20:06:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkeaD-00013z-1n
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 20:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144Ab3FFSGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 14:06:41 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:51347 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117Ab3FFSGj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 14:06:39 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so5265909obb.36
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ell.io; s=google;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=eTUbp0Z86eEbP8sZahO3e23LuY6o9NovuM7TfDoOr58=;
        b=Fk+YqMPeYX8XbuRV77k8714uFZpK5jsf5GkvuCmOzEI8mXDIJ60I05m7ZN50FB9yCy
         +Eqj7Uz9h4HcJ/H65lfLliiNf+Lx/dTb70iFvqh8UmpqauiZbVmiSBTWke/Cf/timQVz
         iIAx4wrZXcbZ+AoFYBet34yZAJOlKcHoauA5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=eTUbp0Z86eEbP8sZahO3e23LuY6o9NovuM7TfDoOr58=;
        b=DmuXIMe6AmUir6j2GyoWs5IkbCsCwkh9eS9lYByfUow4lkAG4GGCPyMU2ilpjVhxeV
         cPH5Y0TaG2b7nwUWdcqhhEKjzq60hd3bDIbsp1aWIakT535QvFclIorEB/BmEUHryFP6
         4Q+R0agTuziPZKZUaqzNxMI05rUD2QiDq0Jqw9cbbC1LEjQBmBuerp3UEYTo1WUwkbL5
         Up9jahkM6nuxMNcKizK/yEHubnWvSA4t/1yMppQxuvSCDrbkKG9ajrCDlzx4bp3HOwPM
         H5At6dE7IqJmGq0i5tBFXggi3F55k2kEJzjgMl0D24BVlciKFUXiokerif/ESrAmhblK
         aZGQ==
X-Received: by 10.60.61.11 with SMTP id l11mr11200945oer.95.1370541999174;
 Thu, 06 Jun 2013 11:06:39 -0700 (PDT)
Received: by 10.60.28.194 with HTTP; Thu, 6 Jun 2013 11:06:39 -0700 (PDT)
X-Originating-IP: [70.197.160.229]
In-Reply-To: <7vmwr57lo1.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQnSsruu/41SkvZl8tpJjEM1GxixpiFk8ZIGP0XmwfcAa9ez8zX4MEskfSw4PsRQvK1CIuLB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226519>

On Tue, Jun 4, 2013 at 2:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> After reading the subject alone, my reaction was "is this sorting
> commits by the name of the author"?
>
> That is one of the expected natural reactions when people hear about
> this option, which is not what you want.
>
> Perhaps naming it --authordate-order (or enhance the command line
> parsing to allow --date-order=author|committer) would give us a
> better UI.

The same comment was raised by someone in IRC when I submitted an RFC
on this. The conclusion we'd arrived at, IIRC, was that the only
remotely-not-ugly solutions were either --authorship-order or
--author-date-order.

I really like the idea of [--date-order[=author|committer]], but
that's getting beyond my knowledge of the code-base. Perhaps I should
just implement the changes to the implementation in *my* revision of
the patch, and leave it up to a future patcher with the requisite
knowledge of the argumentation features to throw in the changes to
that flag quickly? Either that, or implement it as --author-date-order
right *now*, and change it later before it hits Master (so we don't
end up with a no-longer-supported feature?)

(It'd take me many hours to track down the details of how git's
codebase goes around doing that, and then attempting to replicate it,
whereas someone familiar could probably do it in fifteen minutes,
hence the thought-process. Commentary welcome.)
