From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 11:58:15 -0500
Message-ID: <769D0E1A-8399-458B-8328-FF3642D833BC@sb.org>
References: <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati!on.org> <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu> <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org> <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org> <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org> <20080123094052.GB6969@glandium.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-62--538003574; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Theodore Tso <tytso@MIT.EDU>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 17:59:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHiw6-0000BD-0n
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 17:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267AbYAWQ6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 11:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752446AbYAWQ6T
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 11:58:19 -0500
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:52826 "EHLO
	randymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751686AbYAWQ6S (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 11:58:18 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a2.g.dreamhost.com (Postfix) with ESMTP id 576E6EE2EC;
	Wed, 23 Jan 2008 08:58:17 -0800 (PST)
In-Reply-To: <20080123094052.GB6969@glandium.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71555>


--Apple-Mail-62--538003574
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Jan 23, 2008, at 4:40 AM, Mike Hommey wrote:

> On Wed, Jan 23, 2008 at 03:15:02AM -0500, Kevin Ballard  
> <kevin@sb.org> wrote:
>> "In Mac OS X,  SMB, MSDOS, UDF, ISO 9660 (Joliet), NTFS and ZFS file
>> systems all store in one form -- NFC.  We store in NFC since that  
>> what
>> is expected for these files systems."
>
> That's the point. It's stored in NFC, but what applications see is  
> NFD.

I was actually asking for you to show this instead of just asserting  
it, but I realized I have access to an SMB share myself so I just  
tested.

And you're right. That's very curious. I guess they did that because  
the entire Carbon stack was written assuming NFD (back at the same  
time HFS+ was created), and they wanted to provide a consistent  
interface to applications. Since the filesystem already uses NFC,  
renormalizing to NFD shouldn't lose anything (want the original  
representation back? just normalize back to NFC).

>>> - Likewise for Samba shares.
>>
>> See above.
>>
>>> - When I had my problems with iso9660 rockridge volumes using NFC  
>>> (you
>>> can create that just fine with mkisofs), the volume is mounted
>>> without
>>> normalisation, i.e. if you get to a shell and want to access files,
>>> you must use NFC, but at least the Finder does transliteration at
>>> some
>>> stage, because going into the mount point and opening some files  
>>> fail
>>> because it's trying to open the file with the name transliterated to
>>> NFD. I just hope the same doesn't happen with other filesystems.
>>
>> Can you produce a reproducible set of steps for this? Because the
>> Finder shouldn't be doing any of this work on its own, all the
>> normalization stuff happens directly in HFS+.
>
> Simple : on a Linux host, create files with NFC names, and create an  
> iso
> image with mkisofs, with rockridge but no joliet. Burn this to a  
> disc, and
> insert the disc in your OSX host, and try to open files from the  
> finder.
> Interestingly, IIRC, Finder is able to copy the files, though.
>
> As a bonus, try the same with an iso volume name in NFC, it's even  
> better :
> the created mount point is NFD, but it tries to mount on the name in  
> NFC and
> fails. And then you just can't eject the CD anymore.

I was actually hoping for something I could test myself.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-62--538003574
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
DxcNMDgwMTIzMTY1ODE2WjAjBgkqhkiG9w0BCQQxFgQUfxSwvK4Q33IEjVx/D7FJKLiSo9kwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAA5hOGXcl0Z2lccItjEaHB0Muri2xY8n8pY6YcQ+F4MEptIaLfF1mXRGZbfGQnAO6Y0vuaUj
rJo0A4a3bcN4VlMjBHZKUwwWFbJhaVo2y5STahmlp9JvG4zIrCJbrcdmHULNaonP6Y7BvAk7Y0Lg
OCARkoKtkn7fnJImsT57PyEms6DybrtrTJ0M3Xx0XidwWqgbaz5s4W80890+2pIGi+/6F0/RotdB
UWPThyT4kztNqk0/NuDcfLhiZdmPLZOj0JYUnSEFRxI5q6BX/0t4oQEp2zqG0d2TGactusH1obJv
FxvK5+EI4OnBBtBMFIR0fwd1iEpocjTmXAo9KDz7XKMAAAAAAAA=

--Apple-Mail-62--538003574--
