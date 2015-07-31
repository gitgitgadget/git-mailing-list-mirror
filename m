From: Ben Boeckel <mathstuf@gmail.com>
Subject: Re: [PATCH] add ls-remote --get-push-url option
Date: Fri, 31 Jul 2015 14:56:19 -0400
Message-ID: <20150731185619.GA24622@megas.kitware.com>
References: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
 <xmqqfv445fxv.fsf@gitster.dls.corp.google.com>
Reply-To: mathstuf@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 20:56:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLFTo-000685-4h
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 20:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbbGaS4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 14:56:23 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:35717 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbbGaS4W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 14:56:22 -0400
Received: by iodd187 with SMTP id d187so94176675iod.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 11:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EGJ60h4cgeyu7JMmIuIx86YzaoC1EV+GVeVRsE8vyUM=;
        b=Sw3HqdLtkYqQa+g9oFyj/+kAJU3XT/5p0Wt+EMmsP+NAdRc65x3Y6Jn+WWSfDeHebj
         IE6cvjyxiUbQgI/CBLFu7cq3/mNH9OtWEFexZdOffr7E71mjkLSemkw8PTvYXfh3m5Ie
         veVMRiOLqaSmN29IhFVgNnqSfvRdAldKp8yYTpiKTeKd8FuQzTPL3s2FGOWCw/xlcR31
         god/buF6x1zL8gOfEwEEoDb+tx2Y0LiQQxu0hhU3AvQf9XNIsWK/JOkQCu8bhRL/YsR9
         XBO7Hj4oc6a4rw+qE/1A7Y4xNBAc39lkeAei9pLFviMtRdlm3HmKao3blLJvlnFCCcmI
         lelQ==
X-Received: by 10.107.137.154 with SMTP id t26mr7872122ioi.13.1438368981384;
        Fri, 31 Jul 2015 11:56:21 -0700 (PDT)
Received: from megas (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id rr5sm2894498igb.7.2015.07.31.11.56.20
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 11:56:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqfv445fxv.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275063>

On Fri, Jul 31, 2015 at 11:40:12 -0700, Junio C Hamano wrote:
> Probably get-url makes (some) sense because ls-remote is a "fetch
> that does not actually fetch anything".  But "get-push-url" to
> ls-remote makes _no_ sense whatsoever.  ls-remote and fetch do not
> have to know or care about push-url; they do not even have to know
> there exists a thing called "git push" ;-)
> 
> Wouldn't "git push -v -n" or something suit your needs already?

With some sed, yes, but then so would `git remote show` just as useful
too (and in that case, "why does --get-url exist either?" comes to
mind).

Our use case is that we have some scripts which setup the project with
the right remotes and such. To do this, we detect if your remotes are
set up properly already and not ask if things are OK already. This is
currently done with git config --get remote.$x.pushurl, but
`pushInsteadOf` is not expanded and causes false positives.

Where would a utility to have git expand its `pushInsteadOf` aliases
make more sense? Being right beside `insteadOf` expansion made sense to
me (certainly more than some locations for certain flags and actions,
but that boat sailed long ago :) ).

--Ben
