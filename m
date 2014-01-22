From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/6] Make 'git help everyday' work -> relnotes
Date: Wed, 22 Jan 2014 08:33:55 -0000
Organization: OPDS
Message-ID: <D97049A7BB5848B6ABA211DB7D941196@PhilipOakley>
References: <1389309192-5748-1-git-send-email-philipoakley@iee.org><xmqqppo090m7.fsf@gitster.dls.corp.google.com><52CFACBB.7000805@atlas-elektronik.com><F11CD558C63947F9B4AA75501D2F9F62@PhilipOakley><52D91B0E.6080000@atlas-elektronik.com><BA4E87FA92ED4E8FB2C00F013BD7B3FF@PhilipOakley><xmqqob34synq.fsf@gitster.dls.corp.google.com><2D10AF8E0C024CC5A817528582FDE07D@PhilipOakley> <xmqqbnz4svb7.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: =?iso-8859-1?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>,
	"GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 09:34:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5tG2-0004Y1-Qq
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 09:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbaAVIdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 03:33:55 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:39755 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750873AbaAVIdy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jan 2014 03:33:54 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq0/AB+B31ICYJZt/2dsb2JhbABbgws4EAOIf7MjAQIBAQuBARd0giAFAQEBAQIBCAEBHREeAQEhBQYCAwUCAQMVDCUUAQQaBgcXBhMIAgECAwGHbAzBKI58NYJ2gRQEiQ+GF5sUgy08
X-IPAS-Result: Aq0/AB+B31ICYJZt/2dsb2JhbABbgws4EAOIf7MjAQIBAQuBARd0giAFAQEBAQIBCAEBHREeAQEhBQYCAwUCAQMVDCUUAQQaBgcXBhMIAgECAwGHbAzBKI58NYJ2gRQEiQ+GF5sUgy08
X-IronPort-AV: E=Sophos;i="4.95,698,1384300800"; 
   d="scan'208";a="451984428"
Received: from host-2-96-150-109.as13285.net (HELO PhilipOakley) ([2.96.150.109])
  by out1.ip02ir2.opaltelecom.net with SMTP; 22 Jan 2014 08:33:52 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240817>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> I already have a local patch that creates a stalenote.txt file, and
>> includes that in a "release-notes(7)" man page, but it still leaves
>> the actual release notes in a separate plain text file, linked from
>> the man page, rather than being right at hand, which is what I think
>> readers would expect.
>
> Sorry, but I still do not get it.  If you have a script

Ah, no, it's not a script.

I had simply moved the content of the stalenotes section into its own 
file 'stalenotes.txt' which could then be included both within the 
git(1) section it came from, and a new release-notes(7) man page.

With that set up the Documentation/Makefile would generate the man 
pages, with their appropriate links, which can be accessed via the 'git 
help' command.

The big 'however' was that this would not actually include the latest 
release notes as literal text for immediate reading into the 
release-notes(7) man page, which would be my aim, and I think what 
Stefan had suggested as a preferred style.

>                      that reads
> git.txt and extracts its stale-notes section to generate the source
> to be processed into release-notes(7), why can't that script also
> include the contents of the latest release notes inline into its
> output?
>
> My release notes are _not_ written to be compatible with/processable
> by AsciiDoc (they are meant to be mere plain text)---perhaps you are
> wondering if that would make it harder to maintain your script that
> produces release-notes.txt?
>
> Confused...

My thought was that the latest release note would be included as literal 
text, as noted above.
Like you say, it may need to be a script, but I was being cautious about 
what extra work that would entail for each release.

>
>>
>> My other question would be to ask how you normally manage the 
>> up-issue
>> of the stalenotes, and when you would normally create that section in
>> git(1) as I didn't see any ifdef::stalenotes[] being defined anywhere
>> else.
>
> I'm not sure if I am understanding the question right (up-issue?),
> but it used to be that the preformatted and web-reachable manual
> pages at k.org were processed with stalenotes defined (which by the
> way was disabled with adaa3caf "Meta/dodoc.sh: adjust to the new
> layout, 2011-11-15" on the todo branch), and 26cfcfbf "Add release
> notes to the distribution., 2007-02-13" used that facility to
> prepare something like this:
>

I hadn't looked back into that part of history. I was somehow expecting 
to see 'stalenotes' being defined somewhere in the current documenation 
preparation options, hence my question about when you would set 
'stalenotes'.

I'll have a look back at that to see how it was used back then.

>    docs/git.html
>        /git-cat-file.html
>        ...
>    docs/vX.Y.Z/git.html
>    docs/vX.Y.Z/git-cat-file.html
>                ...
>
> where the "latest" one lived immediately underneath docs/*, while
> older ones were in versioned subdirectories.
> 
