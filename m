From: Christian Holtje <docwhat@gmail.com>
Subject: Re: [PATCH v2] pre-commit hook should ignore carriage returns at EOL
Date: Wed, 25 Jun 2008 22:41:12 -0400
Message-ID: <635350D7-2CC0-4FA6-BB74-CE9ED930ECE8@gmail.com>
References: <3BA781AD-4C44-4F43-902A-07580B6CA075@gmail.com> <20080625181422.GC4039@steel.home> <5B163827-204D-4F76-88C9-8F0C93E60AF3@gmail.com> <7vhcbh1g4e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 04:42:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBhRF-0001BX-Ke
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 04:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbYFZClX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 22:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbYFZClW
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 22:41:22 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:59358 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223AbYFZClV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 22:41:21 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1228449ywe.1
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 19:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=CMexgpOjkx+zUzgisHFL/UWfpOID2HYttEt7zKLW44U=;
        b=fmDkG0rROwpt4CNi1Bwb5sOoncmzGKNNsceRPWoxQdbeLEXMKiyWrZS6UIsvGTOpWu
         8++vj0+EBAydgwgm0l5vxHIjT7i3pKu39sUVI3cdO0aSCXV1gCB2BvfJ7G4kXFUc+6Bw
         utls1W6HtTkTfWHzLj7pr31QA8r1DokayYq+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=mDO+uY6SlWCzWNoeOeEaa4ti4igGIm9mrMR39Mq+uhwM0cya9QcSSK0gRH/I3j+m2e
         N3EatafSQ/RKhAO7L6ZT5Ga6avMu31fcVvmFk3ai2sOAHF/t6IhiK+ZawEiN6HuoWX5F
         ThTRY8tFmG6Bm1vcGteY2VliXsSl6lmLdP0hI=
Received: by 10.150.182.15 with SMTP id e15mr903588ybf.72.1214448075142;
        Wed, 25 Jun 2008 19:41:15 -0700 (PDT)
Received: from quicksilver-wifi.gerf.org ( [69.17.59.111])
        by mx.google.com with ESMTPS id 5sm557620ywd.2.2008.06.25.19.41.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Jun 2008 19:41:13 -0700 (PDT)
In-Reply-To: <7vhcbh1g4e.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86387>

On Jun 25, 2008, at 3:14 PM, Junio C Hamano wrote:
> Christian Holtje <docwhat@gmail.com> writes:
>>
>> Junio, do you want me to make this change anyway?  It does make  
>> sense.
>> The unittests for the pre-commit hook may or may not still be   
>> useful.
>
> "disable" is not an issue.  The intention has always been that these  
> are
> samples, and it was an accident that some packaging shipped them  
> enabled
> by mistake.  The patch was to make that mistake harder to make.
>
> The issue now is about keeping the example hooks _relevant_.  The  
> one we
> have does not work well with projects that want to check in files with
> CRLF line endings (iow, without using autocrlf to attempt to make the
> project files cross-platform), so it is irrelevant for such projects  
> with
> Windows origin.
>
> The "solution" you are proposing to strip out \r makes the check less
> useful for projects that want to keep files with LF line endings in  
> the
> commited history, because your patch would stop catching such a  
> mistake of
> adding an CR before LF.  It is robbing from Peter to pay Paul, and I  
> am
> afraid it would make the sample even more irrelevant in the end.  I  
> do not
> think we would want to go there.
>
> I suggested using "diff --check" (and possibly teaching "diff --check"
> other things the scripted example checks, such as conflict markers),
> which would know to honor the line endings specified per path via
> gitattributes(5), instead of building on top of the big Perl script,  
> and I
> had an impression that you agreed to the approach.

I'm completely confused how gitattributes and core.autocrlf interact,  
etc.

I'm expecting the default behavior is that git will leave my files  
alone.  This seems to be the case.

In order for the crlf stuff to work, does it need to have  
core.autocrlf set to true?  If so, that seems wrong.  gitattributes(5)  
is supposed to let you have fine grain control over files.  In  
addition, .git/config isn't passed around via clone so .gitattributes  
works differently depending on who clones it and their settings.

Furthermore, how would 'git diff --check' know what the line endings  
are for a file?  I may have a mostly unix repository but I may have a  
few crlf text files I need to have checked out as crlf on windows (but  
not unix).

Shouldn't the crlf stuff be something like:
.gitattributes:
   eol=crlf -- dos files. no conversion, but diff --check will know  
what is what.
   eol=lf -- unix (otherwise same)
   eol=convert -- stores internally as lf, converts on the fly to lf  
or crlf on filesystem based on system preference. diff --check won't  
worry about new lines matching system-eol if they don't match the eol  
in the file.
   eol=binary -- binary

core.eol=crlf -- ony files with all crlf endings are text.
core.eol=lf -- only files with all lf (no crlf) endings are text.
core.eol=convert -- crlf changes will be converted to lf as per system- 
eol
core.eol=false -- do nothing (default) (binary)

core.system-eol=crlf -- pretend the system is windows
core.system-eol=lf -- pretend the system is unix
core.system-eol=auto -- determine from the system (default)

Otherwise, I have no clue what's going on.  Once someone writes this  
in english, I'll try to write unittests and I'll submit them.  Then  
someone who knows what he/she is doing can write the actual code to  
make the tests pass.  Or maybe I'll try, who knows.

Ciao!
