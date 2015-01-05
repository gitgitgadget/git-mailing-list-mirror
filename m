From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2] doc: core.ignoreStat update, and clarify the --assume-unchanged effect
Date: Mon, 5 Jan 2015 16:04:13 -0000
Organization: OPDS
Message-ID: <909C88A460AB4DDFA7E72216B3218C9F@PhilipOakley>
References: <1420157910-2252-1-git-send-email-philipoakley@iee.org> <xmqqh9w6qppv.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 17:04:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8A8g-0003ky-Sx
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 17:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbbAEQEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 11:04:14 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:28750 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751098AbbAEQEN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jan 2015 11:04:13 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AokOANW0qlROl3wVOmdsb2JhbABcgwaBKoYvbMRyBAKBCRcBAQEBAQEFAQEBASIWIBuEBwUBAQEBAgEIAQEuHgEBHAULAgMFAgEDFQwlFAEEGgYHAxQGEwgCAQIDAYgTDK9ijQEBK493gx2BEwWELYR0hHRNhjKDAQ2FC4UahhGCVIE8PjGCQwEBAQ
X-IPAS-Result: AokOANW0qlROl3wVOmdsb2JhbABcgwaBKoYvbMRyBAKBCRcBAQEBAQEFAQEBASIWIBuEBwUBAQEBAgEIAQEuHgEBHAULAgMFAgEDFQwlFAEEGgYHAxQGEwgCAQIDAYgTDK9ijQEBK493gx2BEwWELYR0hHRNhjKDAQ2FC4UahhGCVIE8PjGCQwEBAQ
X-IronPort-AV: E=Sophos;i="5.07,700,1413241200"; 
   d="scan'208";a="481125179"
Received: from host-78-151-124-21.as13285.net (HELO PhilipOakley) ([78.151.124.21])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 05 Jan 2015 16:04:11 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262022>

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> The assume-unchanged bit, and consequently core.ignoreStat, can be
>> misunderstood. Be assertive about the expectation that file changes 
>> should
>> notified to Git.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>> Overhaul the general wording thus:
>>     1. direct description of what is ignored given first.
>>     2. example instruction of the user manual action required.
>>     3. use sideways indirection for assume-unchanged and update-index 
>> references.
>>     4. add a 'normally' to give leeway for the change detection.
>>
>> This version is on top of the current master, and replaces the patch 
>> in next.
>
> Sorry, you do not replace anything in 'next', once it is in.

My apologies. I'd been too quick to read the 'expecting reroll' to 
properly notice the promotion to next.
>
> I was about to say that I'll try to see if I turn it into
> incremental (at which point some of the above four points after the
> three-dash line might want to be in the log message proper), but the
> AsciiDoc mark-up looks somewhat suspect (we usually do not see
> indentation in the paragraphs continued with "+").  Does this format
> fine for manpage and HTML?

I didn't have access to AsciiDoc at the time.

You are right, it doesn't format correctly, I shouldn't have continued 
with the indentation tabs in the continuation paragraphs. My mistake. I 
can re-roll if that's easiest

>
> Thanks.
>
>> ---
>>  Documentation/config.txt | 18 +++++++++++-------
>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 6862e3e..32e42dd 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -375,13 +375,17 @@ This is useful for excluding servers inside a 
>> firewall from
>>  proxy use, while defaulting to a common proxy for external domains.
>>
>>  core.ignoreStat::
>> - If true, commands which modify both the working tree and the index
>> - will mark the updated paths with the "assume unchanged" bit in the
>> - index. These marked files are then assumed to stay unchanged in the
>> - working tree, until you mark them otherwise manually - Git will not
>> - detect the file changes by lstat() calls. This is useful on systems
>> - where those are very slow, such as Microsoft Windows.
>> - See linkgit:git-update-index[1].
>> + If true, Git will avoid using lstat() calls to detect if files have
>> + changed. Git will set the "assume-unchanged" bit for those tracked 
>> files
>> + which it has updated identically in both the index and working 
>> tree.
>> ++
>> + When files are modified outside of Git, the user will need to stage
>> + the modified files explicitly (e.g. see 'Examples' section in
>> + linkgit:git-update-index[1]).
>> + Git will not normally detect changes to those files.
>> ++
>> + This is useful on systems where lstat() calls are very slow, such 
>> as
>> + CIFS/Microsoft Windows.
>>  False by default.
>>
>>  core.preferSymlinkRefs::
> --


Philip 
