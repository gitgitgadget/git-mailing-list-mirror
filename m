From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 15:31:02 -0500
Message-ID: <8F85366A-C990-47B1-BF60-936185B9E438@sb.org>
References: <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095!@ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <20080121195703.GE29792@mit.edu> <998717B0-0165-4383-AAB8-33BD2A49954E@sb.org> <20080121201530.GF29792@mit.edu>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-19--698037077; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Jan 21 21:32:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH3K5-0007sW-8T
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 21:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756739AbYAUUbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 15:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755836AbYAUUbH
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 15:31:07 -0500
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:35563 "EHLO
	randymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755897AbYAUUbF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 15:31:05 -0500
Received: from KBLAPTOP.WIFI.WPI.EDU (KBLAPTOP.WIFI.WPI.EDU [130.215.171.85])
	by randymail-a2.g.dreamhost.com (Postfix) with ESMTP id 80D91EEE9C;
	Mon, 21 Jan 2008 12:31:03 -0800 (PST)
In-Reply-To: <20080121201530.GF29792@mit.edu>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71328>


--Apple-Mail-19--698037077
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Jan 21, 2008, at 3:15 PM, Theodore Tso wrote:

> On Mon, Jan 21, 2008 at 03:01:43PM -0500, Kevin Ballard wrote:
>>
>> You seem to be under the impression that I'm advocating that git  
>> treat all
>> filenames as unicode strings, and thus change its hashing algorithm  
>> as
>> described. I am not. I am saying that, if git only had to deal with  
>> HFS+,
>> then it could treat all filenames as strings, etc. However, since  
>> git does
>> not only have to deal with HFS+, this will not work. What I am  
>> describing
>> is an ideal, not a practicality.
>
> Well, why are you arguing on the git list about precisely that (when
> you reponsed to Linus), then?

Because of the way in which an argument evolves. This started out as  
"HFS+ is stupid because it normalizes", and I was arguing that said  
normalization wasn't stupid. This turned into an argument as to why HFS 
+ wasn't stupid for normalization, which is basically this argument of  
the ideal. Yes, I realize that it's not producing any practical  
results, but I'm stubborn (as, apparently, are most of you), and I  
believe that if the official stance of the git project is "HFS+ is  
stupid" then there's a lower chance of a patch being accepted then if  
people accept that "HFS+ is different in an incompatible fashion".

>> In other words, what I'm saying is that treating filenames as  
>> strings works
>> perfectly fine, *provided you can do that 100% of the time*. git  
>> cannot do
>> that 100% of the time, therefore it's not appropriate here. The  
>> purpose of
>> this argument is to illustrate that treating filenames as strings  
>> isn't
>> wrong, it's simply incompatible with treating filenames as byte  
>> sequences.
>
> No, it's still broken, because of the Unicode-is-not-static problem.
> What happens when you start adding more composable characters, which
> some future version of HFS+ will start breaking apart?

If you need a static representation, you normalize to a specific form.  
And in fact, adding new composable characters doesn't matter, since if  
they didn't exist before, you couldn't have possibly used them. Unless  
you mean adding new composed forms of existing simpler characters, at  
which point you seem to be arguing for NFD instead of NFC.

> Presumably the whole *reason* why HFS+ was corrupting strings was so
> that "stupid applications" that only did byte comparisons would work
> correctly.  But when you upgrade from Mac OS 10.5 to 10.6, and it adds
> support for new composable characters, and you now take a USB hard
> drive that was hooked up to a MacBook Air, running one version of
> MacOS, and hook it up to another Macintosh, running another version of
> MacOS, the normalization algorithm will be different, so the byte
> comparisons won't work.

I doubt that HFS+ normalized so that "stupid applications" could do  
byte comparisons. But even if that were the case, see previous  
paragraph.

> So all of this extra work which MacOS put in to corrupt filenames
> behind our back doesn't actually do any good; applications still need
> to be smart, or there will be rare, hard to reproduce bugs
> nevertheless.  So if MacOS wants to supply Unicode libraries that
> compare strings keeping in mind Unicode "equivalences" it can be our
> guest (although how they deal with different versions of Unicode with
> different equivalence classes will be their cross to bear).  BUT MacOS
> X SHOULD NOT BE CORRUPTING FILENAMES.  TO DO SO IS BROKEN.

Your entire argument is based on the assumption that HFS+ "corrupts"  
filenames in order to allow dumb clients to do byte comparisons, and I  
don't believe that to be the case. In fact, it's only considered a  
corruption if you care about the byte sequence of filenames, and my  
argument is that, on HFS+, you aren't supposed to care about the byte  
sequence.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-19--698037077
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
DxcNMDgwMTIxMjAzMTAyWjAjBgkqhkiG9w0BCQQxFgQU3ISEGavoBpELC8ADDdrBgyMTEjQwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAAqa8uXmiR/MGgwIp882ikd1uR7eN+FLP2kLlhwn8aSsnzqC0ntkLN0a4pY09KkzxAnO+7iS
olpWcNswioZ52dpD1dG8cmDZdnBZTGFDV5387IBuyXxY0KkTtNy+qS42SONQTu/as3rLHD04wxW+
sycYRZttPfmWzU9IqU/qK9e9bYh3mGHEJTO6tKRB5r+E9iRZTJmKk1j880xdMF9e/MyMJqacT9mJ
cZZSVh5wQqqonwdXkh40U9HGPnxQ9ozou38UursyOzfKfVTx/2KrzdQocGm9YDtErgr0Go1ceQfK
CJ7t3hU3B5ysAnoyvy/YFR3uubiVQUMwhngtZQm+9iEAAAAAAAA=

--Apple-Mail-19--698037077--
