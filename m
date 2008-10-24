From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Fri, 24 Oct 2008 12:52:35 +0200
Message-ID: <cb7bb73a0810240352u28bab2b5p907065680985270a@mail.gmail.com>
References: <gdok16$vh2$1@ger.gmane.org> <4901077A.7050904@gmx.ch>
	 <cb7bb73a0810232355u6de0479cyc260c80227f44e59@mail.gmail.com>
	 <m38wsei8ne.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jean-Luc Herren" <jlh@gmx.ch>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 12:53:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtKIg-00058a-23
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 12:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbYJXKwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 06:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbYJXKwh
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 06:52:37 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:2692 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbYJXKwg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 06:52:36 -0400
Received: by yx-out-2324.google.com with SMTP id 8so268068yxm.1
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 03:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=dZAE1Mn2NXyQurttIkb1PyJ+8kHKk1G43+UzCVT6fXI=;
        b=phCLxgV6fxoT4S3YDCwPWBiUZYMPAc1wTtw4BUHfLJcSrkR/UxtF3jk22LcdJLKwbB
         HmgTzfWV2szPPwUqwVoeEe28UEVPbrKRQMzvzky/7le3vKX3HRoo6wCjH1TmT3R4Bq/z
         Z1y7656HoXzc3mbCxrzWN8V47d6b9XZag/W/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jYY1GFkA8tqaCYruS4dzN1viM0dxt5stLkq+nP0iT9m0ng81IRtmUTEXwxy+wGRAj/
         +qqnOYTecbsJQXH8g0VnCaPtI4TuT9wEp80+M4qT9+Oq1DR1mHrEXKMMvNszLJoYtUAh
         fw62BsoDwgrAIoBOBI08vKSq3Xj+Uq9a33TaE=
Received: by 10.150.155.13 with SMTP id c13mr5700815ybe.7.1224845555872;
        Fri, 24 Oct 2008 03:52:35 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Fri, 24 Oct 2008 03:52:35 -0700 (PDT)
In-Reply-To: <m38wsei8ne.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99026>

On Fri, Oct 24, 2008 at 12:31 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:
>> On Fri, Oct 24, 2008 at 1:23 AM, Jean-Luc Herren <jlh@gmx.ch> wrote:
>
>> > If you decide against a shared repository, maybe you want to
>> > consider to not use ".zit.file/", but ".zit/file/" as the
>> > repository?  This would reduce the clutter to a single directory,
>> > just like with ".git".  And moving files around wouldn't be that
>> > much complicated.
>>
>> Right. I'll give that a shot.
>
> By the way RCS which I use for version control of single files use
> both approaches: it can store 'file,v' alongside 'file' (just like
> your '.zit.file/' or '.file.git/'), but it can also store files on
> per-directory basis in 'RCS/' subdirectory (proposed '.zit/file/' or
> '.zit/file.git/' solution)

Indeed, there's not particular reason why both solutions shouldn't be
available. I'll think about implementing it this way:

$ zit init

will indicate that we want to track many files, and thus it will
create a .zit directory under which RCS files will be available.

$ zit track somefile

will start tracking somefile by setting up .zit/somefile.git if .zit
is available or .somefile.git otherwise.

The only problem then is priority. When looking for a file's repo, do
we look at .file.git first, or .zit/file.git? How does RCS behave in
this case?

> By the way, it would be nice to have VC interface for Emacs for Zit...

I'm afraid someone else will have to take care of that, since Emacs is
not really something I use.

-- 
Giuseppe "Oblomov" Bilotta
