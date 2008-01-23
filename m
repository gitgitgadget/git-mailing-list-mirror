From: Kevin Ballard <kevin@sb.org>
Subject: Re: git filter-branch should run git gc --auto
Date: Wed, 23 Jan 2008 03:18:32 -0500
Message-ID: <C1A3D16A-1797-4895-ABE3-CB6A48C27F1F@sb.org>
References: <20080119123557.GA30778@diana.vm.bytemark.co.uk> <20080119223249.8227.31460.stgit@yoghurt> <1200783050.5724.196.camel@brick> <20080120033737.GA7767@soma> <20080120093436.GA10924@diana.vm.bytemark.co.uk> <7vlk6k8fyp.fsf@gitster.siamese.dyndns.org> <20080121224818.GA8872@untitled> <7vr6gawvkt.fsf@gitster.siamese.dyndns.org> <20080122003911.GA16453@hand.yhbt.net> <7vtzl6vd7v.fsf@gitster.siamese.dyndns.org> <BE604744-0D26-4A39-85CE-B5C0C8C00F9E@sb.org> <7v1w89qmw3.fsf@gitster.siamese.dyndns.org> <60D6C8F5-EF88-48F0-92CA-8E49838C0CB9@sb.org> <4796CB78.2070607@vilain.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-61--569186416; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Jan 23 09:19:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHapC-0005OX-01
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 09:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbYAWISg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 03:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbYAWISg
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 03:18:36 -0500
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:32804
	"EHLO randymail-a8.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750789AbYAWISf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 03:18:35 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a8.g.dreamhost.com (Postfix) with ESMTP id 3CC8CAF81B;
	Wed, 23 Jan 2008 00:18:34 -0800 (PST)
In-Reply-To: <4796CB78.2070607@vilain.net>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71518>


--Apple-Mail-61--569186416
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Jan 23, 2008, at 12:07 AM, Sam Vilain wrote:

> Kevin Ballard wrote:
>> I'm actually considering what the cost would be of switching macports
>> to git (not that it will ever happen - too many anonymous people pull
>> from svn trunk). Right now the svn trunk contains a subfolder for the
>> source code and another subfolder for all ~4400+ Portfiles. In such a
>> theoretical move, I'd want to split that up, probably into two
>> unrelated branches. Doing so would mean running git-filter-branch  
>> over
>> a linear commit history that's 31580 objects long, with a tree filter
>> to prune the dports directory away and a msg filter to remove the  
>> svn-
>> id stuff that git-svn left behind.
>
> You could have used git-svn --no-metadata :)

Sure, except I imported the svn repo with the intention of continuing  
to track it. I'm only floating the idea now of converting the upstream  
repo to git, but as I said before we have enough anonymous checkouts  
of people tracking trunk that we probably can't justify switching  
VCSs, especially when svn is now bundled on Leopard but git isn't.

> Using a commit filter to implement the pruning will be much faster;
> you'll need to make a temporary index, use git-read-tree, git-rm, then
> git-commit.  This way you avoid the expense of checking out the files
> just to delete them in your rewrite hook.

I suspect an index filter would be simpler, and that's really what I  
meant when I said tree filter.

>> I'd also have to
>> figure out some way to remove the commit objects entirely that only
>> reference the dports directory.
>
> This can be done with a parent filter.

Good to know.

>> I'd suggest a patch to run git gc --auto, but it looks like you just
>> did in a subsequent email. As for your comments about the reflogs,
>> can't I disable recording those, at least temporarily? I'd rather
>> clean up after myself as I work rather than balloon the repository  
>> and
>> collapse it in a single operation at the end.
>
> Honestly, the optimisation I mention above will save you much more  
> time.
> Note that you can run git-repack -d every half hour out of cron, it is
> safe and will let it clean as you go.

That's a reasonable suggestion. And I'm still just thinking about  
this, so I have no idea if I'll ever actually have to run git-filter- 
branch on this massive history.

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-61--569186416
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
DxcNMDgwMTIzMDgxODMzWjAjBgkqhkiG9w0BCQQxFgQUp1IXuzZ5wMYgiiohEGwhRiX/KOcwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBABPnRew3Vs4lUoxaSFC0Uj2IQjqhTK7wP/rBFZXK/URL/VVcrY6ZHsAZUDxk7U4b60llWr/N
FFp8lCsPVsASwP8RwMebH6KU2t3tqge/O9ljA+xgEdN2ECxq1ovAiLSTAMbTUcKQY/2ihl4yYHuk
Zur9hRnnwkBwlhcMPTlF/aEXCHuBKihMo6NxBLaRyinNzHbgonmtHfnZ9NwqSrjXfxpX4BrvQU+i
x+SDhtyM8AF88RodUHjckCW6f4355/6pX60I8DFEcB2cQ7EkDSkOEGWP8qdWCJUwMKEeCxDjkYTk
3Pi4dgdBUnrOsLEmU7gyh4utBUe5bbCATOzExEmZmMcAAAAAAAA=

--Apple-Mail-61--569186416--
