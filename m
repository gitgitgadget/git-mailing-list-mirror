From: "Ben Lynn" <benlynn@gmail.com>
Subject: Re: git bugs
Date: Tue, 10 Jun 2008 17:53:40 -0700
Message-ID: <832adb090806101753m19e76512k6cc3f93aecc2599c@mail.gmail.com>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
	 <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org>
	 <832adb090806101145w55729676ya7bcfb41b0413f59@mail.gmail.com>
	 <alpine.LFD.1.10.0806101249580.3101@woody.linux-foundation.org>
	 <832adb090806101609q17a21948nb5814c3b22bd832d@mail.gmail.com>
	 <7v1w34dfn3.fsf@gitster.siamese.dyndns.org>
	 <832adb090806101702l79aba80cvba1eaab029e9ecd5@mail.gmail.com>
	 <7vwskwbz63.fsf@gitster.siamese.dyndns.org>
	 <832adb090806101724k6199694ftbbc6ed151489a6e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 02:54:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Ebk-0004z7-8j
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 02:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980AbYFKAxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 20:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754977AbYFKAxm
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 20:53:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:40037 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754905AbYFKAxl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 20:53:41 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1958881fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 17:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=PhvSVXP+GxxLJrnFXMSMaw7q2OgPhAJ2Wf1Zsh9KtM0=;
        b=aXGM2Dh1rFEkhtP/vcMRNzEzSRrFSWmYP5x9qeewnmbpPnyBetWGe2nQw9n5M5+Xot
         FI4lXT7rLGcvvy5axXj9QB/kUk21WIx8bL2ADeEH3Bv1G5z4tn3GWFaAj71d+mUZkOno
         3Q7mlNso3FP3zHpDe3pLHWX75w1T3js86Pre8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oXd8QK9fi0UZV/cWniv1l2RYBc9mWVgItNzy9oWqvtfvG2Ap3eGs1hqyLpzNcfrC7H
         FovBgJKycvaiZIvAK0dsljwyq3EU29SHRoxQjNqltAuJ25Y1zgsQ+3ITmdVmJ0DBufKe
         VdVaREARSj7m9FudAOSUkYy94aBbFtw1wEvDw=
Received: by 10.86.26.11 with SMTP id 11mr6447832fgz.23.1213145620232;
        Tue, 10 Jun 2008 17:53:40 -0700 (PDT)
Received: by 10.86.79.17 with HTTP; Tue, 10 Jun 2008 17:53:40 -0700 (PDT)
In-Reply-To: <832adb090806101724k6199694ftbbc6ed151489a6e3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84568>

Also, without using the time(2) call, how would we write the timestamp
of the index to the file as Linus suggests? I'm guessing we'd write
it, then read its mtime, and the write it again (just the part storing
the timestamp), but that seems inelegant. In addition, the second
write may happen in the next second and you'll get an mtime different
to that in the file, though that shouldn't matter.

-Ben

On Tue, Jun 10, 2008 at 5:24 PM, Ben Lynn <benlynn@gmail.com> wrote:
> That is problematic. How do I figure out what the filesystem thinks is
> the current time? I could touch some file and read its mtime, but I
> want a shortcut.
>
> Are there any guarantees of any kind? e.g. is the filesystem current
> time at least never ahead of the system time?
>
> -Ben
>
> On Tue, Jun 10, 2008 at 5:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Ben Lynn" <benlynn@gmail.com> writes:
>>
>>> ... I'm making the same
>>> assumptions, i.e. files are not touched while they're being indexed.
>>
>> Actually you are making another assumption that is somewhat worrysome.
>>
>> The filesystem clock and time(2) clock can be skewed and comparing a
>> timestamp you obtain from lstat(2) and time(2) might not give you any
>> meaningful information.  That is why I made this codepath without using
>> time(2) when I did the racy-git work.
>>
>>
>
