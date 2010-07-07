From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 05/13] Drive the debug editor
Date: Wed, 7 Jul 2010 14:53:21 -0500
Message-ID: <20100707195321.GB2911@burratino>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
 <1278461693-3828-6-git-send-email-artagnon@gmail.com>
 <20100707182631.GB2617@burratino>
 <20100707190813.GA16065@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org,
	Julian Foad <julian.foad@wandisco.com>,
	Mark Phippard <mphippard@collab.net>,
	Stefan Sperling <stsp@elego.de>,
	Will Palmer <wmpalmer@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 21:54:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWah9-0006yg-TP
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 21:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314Ab0GGTyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 15:54:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57037 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763Ab0GGTyC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 15:54:02 -0400
Received: by iwn7 with SMTP id 7so42910iwn.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 12:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Wwg4YXiT5PQmyuKNiP4iaAI6/idJVPkXUejKUcJquwQ=;
        b=UZOHrP+OXVwQ3j8YAG5VMr+sWY5qNpbf5t9ZHm6LlkXiB89g+VVkX/TXPSy7ttP4TX
         fXda1a9GiEl7Rl9tZ+xdiZL3X3Q47r0KlbojDS8Cjcv9zl5XSd/V1rBaEx2XSFmuka0m
         RMRi/+Ty+x1CfkjQicDN37Vhe0naahZJq4kAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=J/87Xtfvbly5CZlfmcdgyNYdr5k8C8PgmNIQfe2cMearayfE/aBZTcHuQ7S8SH38DE
         Uv3wmu+qmD2u2K4XKmAs0C7MOJRQiFoqgXbG/QwqNhD69wb8ES75aJyM7DltHKwJfBXk
         htKALVo2QItokWc/DqaLpKpkA2OtRboyseRk0=
Received: by 10.42.36.78 with SMTP id t14mr2150721icd.76.1278532441727;
        Wed, 07 Jul 2010 12:54:01 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm30189808ibh.16.2010.07.07.12.54.00
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 12:54:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100707190813.GA16065@debian>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150496>

Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:
>> Ramkumar Ramachandra wrote:

>>> -	de->apply_textdelta = apply_textdelta;
>>> +	/* de->apply_textdelta = apply_textdelta; */
[...]
> Without this, the program segfaults because the necessary setup for
> applying a text delta hasn't been set up. Perhaps I should explain
> this in my commit message?

Is the default apply_textdelta not a no-op?  What work does it have to
do, and can the skeleton editor be convinced to do the same in patch 4?

>>> +{
>>> +	/* Extract editor and editor_baton from the replay_baton and
>>> +	   set them so that the editor callbacks can use them */
>>
>> This comment just paraphrases the code.  What in particular requires
>> explanation here?
>
> This concept took me some time to wrap my head around: I had to stuff
> the replay_baton with the editor/ editor_baton so that I could set
> them for use in the callback functions.

Ah, okay.  Then I suppose it belongs in the commit message.

Alternatively: why does the tree editor have to persist between calls
replaying the various revisions?  That information could help the
reader understand what is going on.
