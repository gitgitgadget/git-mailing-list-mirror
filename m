From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git filter-branch can "forget" directories on case insensitive filesystems
Date: Wed, 26 Jan 2011 00:31:06 +0100
Message-ID: <AANLkTimvwNs9EkV1GweT7VCdzvcz5J5_0pCUA44urQYH@mail.gmail.com>
References: <AANLkTimOs9m==KaD3BNHcgkTTqNQF1yV0NLA_Ew+iS-N@mail.gmail.com>
 <4D3F38E9.9060902@googlemail.com> <201101252256.03644.j6t@kdbg.org> <4D3F5C42.4040300@googlemail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: smaxein@googlemail.com
X-From: git-owner@vger.kernel.org Wed Jan 26 00:31:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhsMW-0000Fa-P7
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 00:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab1AYXbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jan 2011 18:31:43 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51534 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891Ab1AYXbn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jan 2011 18:31:43 -0500
Received: by bwz15 with SMTP id 15so688448bwz.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 15:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=u5cbnRAESBrBDzq09xCFvm6noMdv4zHAOpWWyubUZz4=;
        b=rL0asj5LM9TBoWMmowGPyaeTe1Fezpw6DsIetdQObra4UGUAuoUammW2ecv0wW+dv2
         U0M05At9eTNaF3+4qPdMHTY+R8P+Hi5hNv6bTJoQNOeBYf+gT8InjutR3ghbXsQusxMM
         p4hiIpG8oU+2JGFbR1kFfWxsnzmAEsbQesMYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=NVwQ7y9T2n9PcaUv1M9YtOgmykIX9iOasjUzWuRMYMQCltuOBpBpPU/AkOsoloXKqV
         nv5m0x4DT2LppG5D7sXAb9J+WGCXKjlgHPT1blTOH6B+pbSI7fzc3qqT5eTOAzxgWCuG
         thzz0dukXMNcXtLV4bo+7DEVdP3MFswzL/o9A=
Received: by 10.204.57.13 with SMTP id a13mr5844605bkh.75.1295998301790; Tue,
 25 Jan 2011 15:31:41 -0800 (PST)
Received: by 10.204.120.197 with HTTP; Tue, 25 Jan 2011 15:31:06 -0800 (PST)
In-Reply-To: <4D3F5C42.4040300@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165488>

On Wed, Jan 26, 2011 at 12:26 AM, Simeon Maxein <smaxein@googlemail.com> wrote:
> Am 25.01.2011 22:56, schrieb Johannes Sixt:
>> On Dienstag, 25. Januar 2011, Simeon Maxein wrote:
>>> In my opinion this is a quite serious issue, because files are lost
>>> without any indication to the user. As of git 1.7.3.1 (tested on
>>> Windows/NTFS with msysGit this time), the problem still exists. Please
>>> give it a look. Fullquote of the problem description / steps to
>>> reproduce follows.
>>>> mkdir testdir
>>>> echo 'abc' >testdir/testfile
>>>> git add testdir
>>>> git commit -m foo
>>>> git rm -r testdir
>>>> mkdir testDir
>>>> echo 'abc' >testDir/testfile
>>>> git add testDir
>>>> git commit -m bar
>> Please retry with current release condidate of 1.7.4; it has some
>> core.ignorecase improvements w.r.t. directories. It could well be that your
>> problem is fixed.
>>
>> -- Hannes
> Thanks for the suggestion. The directory doesn't vanish anymore with
> 1.7.4, so a big Thank You to the developers for improving this. When
> rewriting the second commit ls still prints testdir as lowercase though.
> More of a nitpick, but it would still be neat to have it right.
>

This part is correct behavior  - git's internal representation is case
sensitive. So git's record of the file is still 'testdir', even i
you've deleted it and created a new called 'testDir'.
