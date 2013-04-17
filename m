From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] help.c: add a compatibility comment to cmd_version()
Date: Thu, 18 Apr 2013 00:03:40 +0100
Organization: OPDS
Message-ID: <EAD161814DB34F5AAC61A9EF06873314@PhilipOakley>
References: <1366144405-61438-1-git-send-email-davvid@gmail.com> <3D6BDB8830FC44A38B1AC508488049C0@PhilipOakley> <7vvc7mhzok.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "David Aguilar" <davvid@gmail.com>, <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 01:03:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USbOC-0002K1-Aw
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 01:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966955Ab3DQXDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 19:03:40 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:23448 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966936Ab3DQXDj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 19:03:39 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlMOAJ8pb1FZ8Yje/2dsb2JhbAAuIoMGiSa3WgQBAwGBAxd0ghoFAQEEAQgBAS4eAQEhBQYCAwUCAQMVAQslFAEEGgYHFwYTCAIBAgMBh30KvVWOMGqCbGEDiE6FdJI/hxmDDDs
X-IronPort-AV: E=Sophos;i="4.87,496,1363132800"; 
   d="scan'208";a="69400010"
Received: from host-89-241-136-222.as13285.net (HELO PhilipOakley) ([89.241.136.222])
  by out1.ip07ir2.opaltelecom.net with SMTP; 18 Apr 2013 00:03:35 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221584>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Tuesday, April 16, 2013 11:35 PM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>> int cmd_version(int argc, const char **argv, const char *prefix)
>>> {
>>> + /*
>>> + * The format of this string should be kept stable for 
>>> compatibility
>>> + * with external projects that rely on the output of "git version".

This 'tantalizes without telling', the same complaint that is given 
often for over-succinct commit messages.
How about
    * E.g. git gui uses the extended regular expression "^git version 
[1-9]+(\.[0-9]+)+.*"
    * to check for an acceptable version string.

The ERE is from git-gui.sh:L958.

>>
>> Shouldn't the expected format of our known external project also be
>> indicated?
>> ...
>>>  printf("git version %s\n", git_version_string);
>
> It is fairly clear from the commented code that the only guarantee
> they will be getting is that it begins with a string "git version ".

I read the code the opposite way. It says "This is the code to be 
changed" if you (anyone doing tweaks) want a special version string.

> git_version_string[] has anything of the builder's choice.  I am not
> sure if there anything more to "indicate".
>
> Really, if you run
>
> $ git version
>
> and you get "Git Source Code Management Version 3.56" from its
> output, it is likely that the version is very different from what
> you know, and you should not assume any your assumption would hold.

Again I am reading this from the opposite side. There would be no 
assumption of difference if it _passed_ the test scripts. Unfortunately 
it wouldn't be friendly to other tools (like git gui). Hence my 
suggestion of the basic test that a "passing" git would produce a 
consistent version string. It still allows the supplier's suffixes to be 
added, but not the prefixes. The test suite tests that git is 'good 
enough for most usages and picks up regressions. No?

Obvious inconsistent special versions would fail in many other places.
>
>> Or mention "such as git gui"?
>
> I do not see what it would buy us.  It is not like it is OK as long
> as we upadte Git gui at the same time.

Philip 
