From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 15:59:51 -0500
Message-ID: <20863708-2F5A-4E9A-BA67-A6C29D324BD8@sb.org>
References: <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095!@ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <20080121195703.GE29792@mit.edu> <998717B0-0165-4383-AAB8-33BD2A49954E@sb.org> <20080121201530.GF29792@mit.edu> <8F85366A-C990-47B1-BF60-936185B9E438@sb.org> <20080121204614.GG29792@mit.edu>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-29--696307996; micalg=sha1; protocol="application/pkcs7-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 22:00:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH3kl-0000il-Hv
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 22:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205AbYAUU7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 15:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbYAUU7y
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 15:59:54 -0500
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:35040
	"EHLO randymail-a8.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752822AbYAUU7x (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 15:59:53 -0500
Received: from KBLAPTOP.WIFI.WPI.EDU (KBLAPTOP.WIFI.WPI.EDU [130.215.171.85])
	by randymail-a8.g.dreamhost.com (Postfix) with ESMTP id 8D36DAF832
	for <git@vger.kernel.org>; Mon, 21 Jan 2008 12:59:52 -0800 (PST)
In-Reply-To: <20080121204614.GG29792@mit.edu>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71338>


--Apple-Mail-29--696307996
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Note: resent to list due to bounce.
Original CC list: tytso@MIT.EDU, torvalds@linux-foundation.org, peter@softwolves.pp.se 
, mjscod@web.de, melo@simplicidade.org

On Jan 21, 2008, at 3:46 PM, Theodore Tso wrote:

> On Mon, Jan 21, 2008 at 03:31:02PM -0500, Kevin Ballard wrote:
>>> No, it's still broken, because of the Unicode-is-not-static problem.
>>> What happens when you start adding more composable characters, which
>>> some future version of HFS+ will start breaking apart?
>>
>> If you need a static representation, you normalize to a specific  
>> form. And
>> in fact, adding new composable characters doesn't matter, since if  
>> they
>> didn't exist before, you couldn't have possibly used them.
>
> Sure you can.  Suppose you unpack the same tar file or zip file that
> contains one of these new-fangled characters, one on a MacOS 10.5
> system, and one on a MacOS 10.9 system.  How HFS+ will corrupt that
> filename will differ depending which version of MacOS you are running.
> Hence, normalizing the filename when you store it is stupid and
> broken.  MacOS and its applications and libraries want to do
> normalization in the privacy of its own address space, that's it's
> business.  It can pursue any fetish it wants, among consenting adults.
> Safe, sane and consensual, and all that... well, consensual, anyway.
> I'm not sure about "safe" and "sane"....

You're making the huge assumption that the HFS+ normalization  
algorithms will change. As the technote states:

"Platform algorithms tend to evolve with the Unicode standard. The HFS  
Plus algorithms cannot evolve because such evolution would invalidate  
existing HFS Plus volumes."

> My arguement is basically is that there is absolutely no value in what
> HFS+ is doing, by corrupting filenames --- if you want to call it
> "normalizing" them, fine, but since Unicode is not static, so you
> can't even call it a "canonical" form.  It's just some random
> corruption of what was passed in at open(2) time, that can and will
> change depending on what version of MacOS you are running.

Again with the huge assumptions.

> If you want to play the insane Unicode game of "equivalent"
> characters, you have to do it at comparison time, so there's no point
> trying to "normalize" them when you store them.  It doesn't buy you
> anything, and it causes all sorts of pain.

It must have bought somebody something, or they never would have done  
it.

>> Your entire argument is based on the assumption that HFS+ "corrupts"
>> filenames in order to allow dumb clients to do byte comparisons,  
>> and I
>> don't believe that to be the case.
>
> OK, what's your reason for why HFS+ corrupts filenames?  What do you
> think is its excuse?  What problem does it solve?  If the answer is
> "no reason at all, but because it *can*", according to the Great God
> Unicode, then that's really not very impressive....

I have no idea why HFS+ stores filenames in a normalized form, and  
further I am smart enough to know that speculating is completely  
pointless. I assume the authors had a good reason (which should be a  
safe assumption, filesystem authors are a smart bunch). The reason may  
not be valid anymore, but if it was valid back in 1998, then I can  
accept it without complaining.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-29--696307996
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGMjCCAusw
ggJUoAMCAQICEDsG8BKvlrEW0HUBIxWIgjUwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDQyMzIxMjM0OVoXDTA4MDQyMjIxMjM0
OVowVzEQMA4GA1UEBBMHQmFsbGFyZDEOMAwGA1UEKhMFS2V2aW4xFjAUBgNVBAMTDUtldmluIEJh
bGxhcmQxGzAZBgkqhkiG9w0BCQEWDGtldmluQHNiLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAN/koURrN2ndrAiuAuHHrdFz+hLGQ7ZsXloGnObjALGOFY3Kmk2FCwAJPIha5GfM
YFmZIoqxs+DbOWOn6KZ9hcQ5wf4EOgokayrEs3G72T+G8ZE4aXrw0CWJzKLjaIQeDZNZoHA44jlZ
dG70wtZske898IoPz6YHpkcXiulllATfd8Pa7EgjPri5hKFiRXKI52OsOQTX6cNMMZJUIm8DvfQ5
jmDyAtywNZGSGeUAMbWnpuLq7H18zpye2Q1hr+p4kucazMb+i7OHXPvX7yx2jMjhN5jw/gYkuzQQ
JExp1fJyAZQ/av/ZgaxWchhhi4ziFXIlX3B09DTlOQlF53P3fi0CAwEAAaMpMCcwFwYDVR0RBBAw
DoEMa2V2aW5Ac2Iub3JnMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAw/qc6zq+0Qy2
XaodDlt2L6Vq1DzaVWjV152BFjidmsyhyCkCuyYdAcDp17opIfrNCBbOX5DdY6cpFpnSCxCZeIEB
PDc3TaaFPtzr8qrpcNDohRSdt+qFLUeMHzlidAiAjvjI3tPKv3JLTakWdQR/XPHsg4mWoaVQU2hM
HOQBw8EwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBD
b25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYD
VQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFs
LWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQsw
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQAD
gY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow
1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenpruf
ZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBD
BgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVl
bWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVM
YWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0wh
uPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBP
ZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDEDCCAwwCAQEwdjBi
MQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEDsG8BKvlrEW0HUBIxWI
gjUwCQYFKw4DAhoFAKCCAW8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
DxcNMDgwMTIxMjA1OTUxWjAjBgkqhkiG9w0BCQQxFgQUEM6yfBlgqJOmCX4DxJFWpXaWzQEwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAAVlfAjQGJgOU+03rPXZyrB56CwKixeTtiQOA4v+QQbKHTaESQXJhwQ8FjPGEnDVfejPJpXY
wZ8FgJKOcLsZdHNMho+iyu2S5Ph1CSZdcHrZK5NWfqSkToLBndAsu7AUVju4gSyQCSMltk3msz/0
jLQtxmMkwHUw5guloSN+oXW+s/CMdxgCmyTcO8hELyzkdUUzv6FSEwDqUnCkhkoPPcUW3LWh6dIP
ujZayYTpwQZqL/hOpmrbh2dXf5HUJy77d7B7NuUYOkzEklmJ1ldFFnRVorWdDsoap6E5y+YW4Bvt
aw+LDXTIFAHPAHo/KRlQBHJEBdVdc1iJnpItDvMqp1EAAAAAAAA=

--Apple-Mail-29--696307996--
