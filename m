From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 16/33] t3210: test for spurious error messages for dangling
 packed refs
Date: Tue, 16 Apr 2013 16:14:30 +0200
Message-ID: <516D5CC6.10505@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu> <1365944088-10588-17-git-send-email-mhagger@alum.mit.edu> <7vobdfvglf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 16:14:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US6ec-0002aI-AU
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 16:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935537Ab3DPOOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 10:14:34 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:51067 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933779Ab3DPOOd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 10:14:33 -0400
X-AuditID: 12074413-b7f226d000000902-62-516d5cc89ddf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id EE.97.02306.8CC5D615; Tue, 16 Apr 2013 10:14:32 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3GEEUDG030460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 16 Apr 2013 10:14:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vobdfvglf.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqHsiJjfQYOlfK4uuK91MFg29V5gt
	Vj6+y2zxo6WH2YHFo/39O2aPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE7Y9uptIIl
	nBUT+twaGDezdzFyckgImEjseXySEcIWk7hwbz0biC0kcJlR4v6eki5GLiD7OJPE1hc9YA28
	ApoSfw5tZAKxWQRUJeZtWAvWwCagK7GopxksLioQJrFq/TJmiHpBiZMzn7CA2CICahIT2w4B
	2RwczAIxEueuCoGEhQViJdZO+cMOsWsFo8SzL0/BdnEKmEl83TsL7DhmAR2Jd30PmCFseYnt
	b+cwT2AUmIVkxSwkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuul5tZopeaUrqJ
	ERLKwjsYd52UO8QowMGoxMMbIJ8TKMSaWFZcmXuIUZKDSUmUNyw8N1CILyk/pTIjsTgjvqg0
	J7X4EKMEB7OSCO9ZR6Acb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mC
	d1k0UKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KErji4FxCpLiAdr7EaSdt7gg
	MRcoCtF6ilGXY+WVJ68ZhVjy8vNSpcR580CKBECKMkrz4FbAEtcrRnGgj4V5I0CqeIBJD27S
	K6AlTEBLDqzKBllSkoiQkmpgFPK6vjKsIVT3jKnA64e3Xr4uuWXNm5UcuoTH2X338/2lxcLv
	0yS67zyamr/Jrii1S7wtQnz7xsXHXO7FeVZoqpS1bi5uv2Eq33ptOQuf1KcfpQYS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221419>

On 04/15/2013 07:39 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> How can I get rid of the sleeps in these tests?
> 
> Would test-chmtime help?

Maybe I should take a step back and ask why it isn't easier to expire
things regardless of age, which is sometimes a reasonable thing to do
even outside of test suites.  In particular, it seem to me that the most
obvious interpretation of

	git reflog expire --expire=now --all

would be that it expires *everything*.  But in fact it seems to only
expire things that are at least one second old, which doesn't seem at
all useful in the real world.  "--expire=all" is accepted without
complaint but doesn't do what one would hope.  Something like
"--expire=$(($(date +%s)+3600))" works, but it is not very convenient
(is it portable?).

I guess I can use test-chmtime for my particular test, though I will
have to pass it the explicit names of the logfile(s), like

    find .git/logs -type f -print0 | xargs -0 test-chmtime =-60

I guess that's what I'll do if no better solution comes up.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
