From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] rev-parse --parseopt: add the --sticked-long mode
Date: Sun, 27 Oct 2013 06:45:50 +0100
Message-ID: <526CA88E.90802@alum.mit.edu>
References: <20131016223306.GN9464@google.com> <1382732291-5701-1-git-send-email-boklm@mars-attacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Nicolas Vigier <boklm@mars-attacks.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 06:53:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaJHX-0007IN-LB
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 06:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758Ab3J0Fw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 01:52:56 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:59830 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751693Ab3J0Fwz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Oct 2013 01:52:55 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Oct 2013 01:52:55 EDT
X-AuditID: 1207440d-b7f4c6d000004a16-d9-526ca88fe6bd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 62.70.18966.F88AC625; Sun, 27 Oct 2013 01:45:51 -0400 (EDT)
Received: from [192.168.69.9] (p57A242CF.dip0.t-ipconnect.de [87.162.66.207])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9R5jnJt027834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 27 Oct 2013 01:45:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <1382732291-5701-1-git-send-email-boklm@mars-attacks.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1O1fkRNk0PZF2eLanQ1MFl1Xupkc
	mDxm3lvA5PF5k1wAUxS3TVJiSVlwZnqevl0Cd8bLc5PYC/axVWxetZW5gXEKaxcjJ4eEgInE
	li27mSFsMYkL99azdTFycQgJXGaUuD7lPAuEc5ZJ4vuMf0wgVbwCmhKfTzxmB7FZBFQlfj1s
	A+tmE9CVWNTTDFYjKhAisXDVcXaIekGJkzOfsIDYIgIOEgfOvwGrERZwk1h+9DtYjZBAhsSn
	91sZQWxOoHj73JVgNrOAjsS7vgfMELa8xPa3c5gnMPLPQjJ2FpKyWUjKFjAyr2KUS8wpzdXN
	TczMKU5N1i1OTszLSy3SNdLLzSzRS00p3cQICUneHYz/18kcYhTgYFTi4dUIzQkSYk0sK67M
	PcQoycGkJMrrOwcoxJeUn1KZkVicEV9UmpNafIhRgoNZSYR3VwdQjjclsbIqtSgfJiXNwaIk
	zqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwft2GVCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5K
	alFiaUlGPCgm44uBUQmS4gHa67AcZG9xQWIuUBSi9RSjMce8Lx++MXLsuf/xG6MQS15+XqqU
	OK85SKkASGlGaR7cIlgyesUoDvS3MK8PSBUPMJHBzXsFtIoJaNXfK1kgq0oSEVJSDYzGws/3
	BtxeszlYzqSiXJTBqstWM99G5Gwyc9OVGIcDkgGTr/35ZsvK48Cq//jm/hmTJK/d2/bbz+uo
	wYatvJfqz2+50VkdGjPn4QZRoTvnXn3uniWZomcvfPWZ4MpnJqKNzbWWadP7N8lw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236776>

On 10/25/2013 10:18 PM, Nicolas Vigier wrote:
> Add the --sticked-long option to output the options in their long form
> if available, and with their arguments sticked.
> 
> Contrary to the default form (non sticked arguments and short options),
> this can be parsed unambiguously when using options with optional
> arguments :
> 
>  - in the non sticked form, when an option is taking an optional argument
>    you cannot know if the next argument is its optional argument, or the
>    next option.
> 
>  - the long options form allows to differenciate between an empty argument
>    '--option=' and an unset argument '--option', which is not possible
>    with short options.

Trivial: s/differenciate/differentiate/

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
