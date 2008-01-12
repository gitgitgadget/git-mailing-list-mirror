From: Kevin Ballard <kevin@sb.org>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Fri, 11 Jan 2008 20:16:40 -0500
Message-ID: <B2968E86-D43E-4F5E-921F-DF8A15886C98@sb.org>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org> <200801120026.01930.robin.rosenberg@dewire.com> <1973E1D5-C8CC-4979-A085-85A2C5A13E57@sb.org> <200801120115.41274.robin.rosenberg@dewire.com> <191B60D7-FD89-48D8-8D48-C91645D4814D@sb.org> <7v7iif28i2.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801120139170.8333@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-14-602585457; micalg=sha1; protocol="application/pkcs7-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 02:17:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDUzq-0006UM-Fi
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 02:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758691AbYALBQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 20:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756962AbYALBQo
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 20:16:44 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:43845 "EHLO
	randymail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755430AbYALBQn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jan 2008 20:16:43 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a3.g.dreamhost.com (Postfix) with ESMTP id 5A958185C59
	for <git@vger.kernel.org>; Fri, 11 Jan 2008 17:16:42 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0801120139170.8333@wbgn129.biozentrum.uni-wuerzburg.de>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70243>


--Apple-Mail-14-602585457
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Jan 11, 2008, at 7:40 PM, Johannes Schindelin wrote:

> On Fri, 11 Jan 2008, Junio C Hamano wrote:
>
>> Kevin Ballard <kevin@sb.org> writes:
>>
>>> Is there a reason for this? It seems like it would be trivial to end
>>> up with misdiagnosed "untracked" files when using any language other
>>> than English given this behaviuor.
>>
>> No.  The assumption of the code has always been that sane filesystems
>> would return from readdir() the names you gave from creat().
>
> We do not really have to rehash that whole discussion for the Nth  
> time, do
> we?


Apparently so. By Junio's definition, HFS+ is not a sane filesystem,  
and as git grows more popular with OS X users, this issue is going to  
crop up more frequently.

According to the HFS+ Volume Format technote[1], filenames in HFS+ are  
stored in normalized, canonical order. To be more specific, they're  
stored in a special apple variant of Unicode Normal Form D (the  
special variant is for preserving round-trip with older encodings with  
certain codepoint ranges[2]).

In other words, if you hand an HFS+ filesystem a filename that  
contains unicode characters, what you get back later may be in a  
different format. And that's going to be a problem if git doesn't deal  
with this.

[1]: http://developer.apple.com/technotes/tn/tn1150.html#UnicodeSubtleties
[2]: http://developer.apple.com/qa/qa2001/qa1173.html

Note: CC list stripped because this is a re-sent email, as the list  
bounced the last one that contained a text/html alternate.

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-14-602585457
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
DxcNMDgwMTEyMDExNjQxWjAjBgkqhkiG9w0BCQQxFgQUP3RCe8j7k5MT4i9WnmjFR0VgCrwwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAH7JZOyZw1ktZVFicubuiceCqnrkgNkavszHdP0UR75WDGXD2E+E5/WprVSibaSqCJsv+eJ6
5Jqc0EIAp2r45PQeA2HXeWIM8OsNpmwen9uPpI7H10FdtWEatbGrnaUmiqcdJJDkq5cABjR0miSz
cKPVoEa6kC4Fm8vbrI72hgNaM6oJOfQi3WrHGC9nxlw1Ph3CgF+p0cdgVY+FLKWFkBXVBYBbQBcy
Z9U810l94R64A5xEjLiatULqgbuwDEk03O6sAAu6YCGc3pWtgZEv5hCGLc60+92aGaLMel4LVkQi
x6onriv5W/30nks7/EY3Mo0TbpbA5OBtKagxQz36sP4AAAAAAAA=

--Apple-Mail-14-602585457--
