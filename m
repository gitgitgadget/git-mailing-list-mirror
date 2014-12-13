From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] doc: core.ignoreStat clarify the --assume-unchanged effect
Date: Sat, 13 Dec 2014 20:39:05 -0000
Organization: OPDS
Message-ID: <C25BE5AA16BF46468ABC6814549D3134@PhilipOakley>
References: <1418341733-1656-1-git-send-email-philipoakley@iee.org> <1418341733-1656-2-git-send-email-philipoakley@iee.org> <alpine.DEB.1.00.1412121149040.13845@s15462909.onlinehome-server.info>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	=?iso-8859-1?Q?S=E9rgio_Basto?= <sergio@serjux.com>,
	"Johannes Sixt" <j6t@kdbg.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Duy Nguyen" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 21:38:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XztSI-00015w-Ld
	for gcvg-git-2@plane.gmane.org; Sat, 13 Dec 2014 21:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997AbaLMUiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2014 15:38:17 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:33264 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753645AbaLMUiQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Dec 2014 15:38:16 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Am8RAJGijFQCYJYyPGdsb2JhbABZgwaBKoYwbMRhBAKBEhcBAQEBAQEFAQEBATggG4QHBQEBAQECAQgBAR0RHgEBHAUFBgIDBQIBAxUDCSUUAQQaBgcDFAYBEggCAQIDAYgHAwkMx0GPEwEBAQcCAR+NSoIogx2BEwWEJoRvhG1MiS6KIYYLhA4+MIEDJIEcAQEB
X-IPAS-Result: Am8RAJGijFQCYJYyPGdsb2JhbABZgwaBKoYwbMRhBAKBEhcBAQEBAQEFAQEBATggG4QHBQEBAQECAQgBAR0RHgEBHAUFBgIDBQIBAxUDCSUUAQQaBgcDFAYBEggCAQIDAYgHAwkMx0GPEwEBAQcCAR+NSoIogx2BEwWEJoRvhG1MiS6KIYYLhA4+MIEDJIEcAQEB
X-IronPort-AV: E=Sophos;i="5.07,572,1413241200"; 
   d="scan'208";a="537248522"
Received: from host-2-96-150-50.as13285.net (HELO PhilipOakley) ([2.96.150.50])
  by out1.ip03ir2.opaltelecom.net with SMTP; 13 Dec 2014 20:38:11 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261395>

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>  Friday, 
December 12, 2014 10:56 AM
> Hi Philip,
>
> On Thu, 11 Dec 2014, Philip Oakley wrote:
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index c26a7c8..81570b7 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -354,10 +354,11 @@ proxy use, while defaulting to a common proxy 
>> for external domains.
>>  core.ignoreStat::
>>  If true, commands which modify both the working tree and the index
>>  will mark the updated paths with the "assume unchanged" bit in the
>> - index. These marked files are then assumed to stay unchanged in the
>> - working tree, until you mark them otherwise manually - Git will not
>> - detect the file changes by lstat() calls. This is useful on systems
>> - where those are very slow, such as Microsoft Windows.
>> + index. These marked files are then expected to stay unchanged in 
>> the
>> + working tree. If you change them you should mark their update 
>> manually.
>> + Git will normally not detect the file changes by lstat() calls.
>> + This is useful on systems where those calls are very slow, such as
>> + cifs/Microsoft Windows.
>>  See linkgit:git-update-index[1].
>>  False by default.
>
> I think that the new wording is better, but still can be 
> misunderstood.
> How about this instead:
>
> -- snip --
> core.ignoreStat::
> If true, Git will not try to detect when files were modified.
 "not _normally_ try"? - is there a guarantee that ignoreStat will 
switch off ALL checks?
Is there a list of those commands which will, implicitly, check?

> When Git commands are used to modify files, Git will know that
> they were modified, but when files are modified outside of Git,
+ e.g. by the user, external SDK or other tools,
> the user will need to stage the modified files explicitly; they
> will not be reported as changed e.g. by linkgit:git-status[1].
The git-status man page give no indication either way as to the effect 
of this ignoreStat or the --assume-unchanged flags (or --skip-worktree). 
User expectations can go either way.

I was thinking I'd need to reference 'git update-index --really-refresh 
<file>' (but filenames beginning with . are discarded, so no '--all' 
equivalence !)

> +
> This is useful on systems where lstat() calls are very slow, such as
> CIFS/Microsoft Windows.
> See linkgit:git-update-index[1].
> False by default.
> -- snap --
>
> In other words, I would try to skip the "assume unchanged" flag
> altogether, it is prone to confuse readers unfamiliar with the inner
> workings of the index.
It's certainly confused many, to the point that the false information 
has become the accepted truth.


I'll take on board most of the suggestions.

This documenation clarification problem (users asking "how to 
temporarily mark files such that git will ignore their changes" getting 
confused) has grown arms and legs. In Duy's code fix, I see a repeated 
pattern that should have a macro; If only there was a good name for what 
it means (ce->ce_flags & (CE_VALID | CE_SKIP_WORKTREE)), which extends 
ce_skip_worktree(ce).

Longer term I'm also looking for a method for the situation that would 
indicate that the local repo)doesn't even have a copy of 'that sha1' 
blob or tree (in the same way as a submodule sha1s) so that one can do a 
narrow clone/fetch for privacy/security reasons.

--
Philip
