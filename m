From: Harald Weppner <harry.weppner@gmx.net>
Subject: http push to WebDAV server fails (apache 2.2 under Win) - possible bug!?
Date: Sun, 4 Jan 2009 22:26:16 -0800
Message-ID: <65B460DF-29D3-4651-93C9-794946DA8437@gmx.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; boundary=Apple-Mail-22--573493672; micalg=sha1; protocol="application/pkcs7-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 05 07:27:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJiwH-0006H0-C4
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 07:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbZAEG0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 01:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbZAEG0X
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 01:26:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:36499 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750878AbZAEG0X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 01:26:23 -0500
Received: (qmail invoked by alias); 05 Jan 2009 06:26:19 -0000
Received: from c-24-6-250-70.hsd1.ca.comcast.net (EHLO [192.168.15.101]) [24.6.250.70]
  by mail.gmx.net (mp066) with SMTP; 05 Jan 2009 07:26:19 +0100
X-Authenticated: #302007
X-Provags-ID: V01U2FsdGVkX1/X2aM0pgvXzYGsJUUXoSSsjSGWq1HFuEx/vD3zsT
	MO9Lt9f2VQsHGz
X-Mailer: Apple Mail (2.930.3)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104565>


--Apple-Mail-22--573493672
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Hi there,

just trying to get started to host a remote repository on a WebDAV  
share (served by apache2.2 on Windows). When I attempt to push from my  
local repository it indicates a 405 failure on a PUT of a  
*opaquelocktoken:* resource (cf. apache access log below). I don't  
know WebDAV in detail to know what's going wrong here but the colon in  
the resource name looks suspicious as it's not a permitted character  
under Windows. Could this indeed be a problem of not escaping the  
resource name properly?

Thanks & cheerio, Harry.

 > git push -v origin master
Pushing to http://user@example.com/webdav/repos/example.git/
Fetching remote heads...
   refs/
   refs/heads/
   refs/tags/
updating 'refs/heads/master'
   from 0000000000000000000000000000000000000000
   to   d310d475c459f7440a9a4ab8ae518f3a91011eb2
     sending 12 objects
PUT 9d68391c5426d3b3c69a6b4c43c1110d13a710d5 failed, aborting (22/405)
PUT 57964966cd88e6a3a61c46ed4b186f26d5133dab failed, aborting (22/405)
PUT 7e03ccd9dcbb5a2770cc5e52aa168a97897ce01b failed, aborting (22/405)
PUT 67d59f8095ad0b5d90b50b05634038c831871f05 failed, aborting (22/405)
PUT 726f7925fa8539c202558d1cf7567c173fed6b42 failed, aborting (22/405)
error: failed to push some refs to 'http://user@example.com/webdav/repos/example.git/'



Here's how the apache error log looks like

[Sun Jan 04 21:51:27 2009] [error] [client xxx.xxx.xx.xxx] File does  
not exist: C:/xampp/webdav/repos/example.git/info/refs
[Sun Jan 04 21:51:27 2009] [error] [client xxx.xxx.xx.xxx] File does  
not exist: C:/xampp/webdav/repos/example.git/objects/info/packs


and this is apache's access log (showing the 405 errors)

[04/Jan/2009:21:51:26 -0800] "PROPFIND /webdav/repos/example.git/ HTTP/ 
1.1" 207 588 "-" "git/1.6.1"
[04/Jan/2009:21:51:27 -0800] "HEAD /webdav/repos/example.git/info/refs  
HTTP/1.1" 404 - "-" "git/1.6.1"
[04/Jan/2009:21:51:27 -0800] "HEAD /webdav/repos/example.git/objects/ 
info/packs HTTP/1.1" 404 - "-" "git/1.6.1"
[04/Jan/2009:21:51:27 -0800] "PROPFIND /webdav/repos/example.git/refs/  
HTTP/1.1" 207 2637 "-" "git/1.6.1"
[04/Jan/2009:21:51:27 -0800] "PROPFIND /webdav/repos/example.git/refs/ 
heads/ HTTP/1.1" 207 950 "-" "git/1.6.1"
[04/Jan/2009:21:51:27 -0800] "PROPFIND /webdav/repos/example.git/refs/ 
tags/ HTTP/1.1" 207 950 "-" "git/1.6.1"
[04/Jan/2009:21:51:27 -0800] "MKCOL /webdav/repos/example.git/refs  
HTTP/1.1" 301 433 "-" "git/1.6.1"
[04/Jan/2009:21:51:28 -0800] "MKCOL /webdav/repos/example.git/refs/  
HTTP/1.1" 405 1060 "-" "git/1.6.1"
[04/Jan/2009:21:51:28 -0800] "MKCOL /webdav/repos/example.git/refs/ 
heads HTTP/1.1" 301 439 "-" "git/1.6.1"
[04/Jan/2009:21:51:28 -0800] "MKCOL /webdav/repos/example.git/refs/ 
heads/ HTTP/1.1" 405 1060 "-" "git/1.6.1"
[04/Jan/2009:21:51:28 -0800] "LOCK /webdav/repos/example.git/refs/ 
heads/master HTTP/1.1" 200 471 "-" "git/1.6.1"
[04/Jan/2009:21:51:28 -0800] "PROPFIND /webdav/repos/example.git/ 
objects/d3/ HTTP/1.1" 404 1138 "-" "git/1.6.1"
[04/Jan/2009:21:51:28 -0800] "PROPFIND /webdav/repos/example.git/ 
objects/24/ HTTP/1.1" 404 1138 "-" "git/1.6.1"
[04/Jan/2009:21:51:28 -0800] "PROPFIND /webdav/repos/example.git/ 
objects/62/ HTTP/1.1" 404 1138 "-" "git/1.6.1"
[04/Jan/2009:21:51:28 -0800] "PROPFIND /webdav/repos/example.git/ 
objects/ca/ HTTP/1.1" 207 950 "-" "git/1.6.1"
[04/Jan/2009:21:51:28 -0800] "PROPFIND /webdav/repos/example.git/ 
objects/9c/ HTTP/1.1" 404 1138 "-" "git/1.6.1"
[04/Jan/2009:21:51:29 -0800] "PROPFIND /webdav/repos/example.git/ 
objects/7e/ HTTP/1.1" 207 950 "-" "git/1.6.1"
[04/Jan/2009:21:51:29 -0800] "PROPFIND /webdav/repos/example.git/ 
objects/6f/ HTTP/1.1" 404 1138 "-" "git/1.6.1"
[04/Jan/2009:21:51:29 -0800] "PROPFIND /webdav/repos/example.git/ 
objects/72/ HTTP/1.1" 207 950 "-" "git/1.6.1"
[04/Jan/2009:21:51:29 -0800] "PROPFIND /webdav/repos/example.git/ 
objects/67/ HTTP/1.1" 207 950 "-" "git/1.6.1"
[04/Jan/2009:21:51:29 -0800] "PROPFIND /webdav/repos/example.git/ 
objects/57/ HTTP/1.1" 207 951 "-" "git/1.6.1"
[04/Jan/2009:21:51:29 -0800] "PROPFIND /webdav/repos/example.git/ 
objects/9d/ HTTP/1.1" 207 950 "-" "git/1.6.1"
[04/Jan/2009:21:51:29 -0800] "PUT /webdav/repos/example.git/objects/9d/ 
68391c5426d3b3c69a6b4c43c1110d13a710d5_opaquelocktoken: 
35019a69-7377-2545-a7fa-0f7888f6e3bc HTTP/1.1" 405 1058 "-" "git/1.6.1"
[04/Jan/2009:21:51:29 -0800] "PUT /webdav/repos/example.git/objects/ 
57/964966cd88e6a3a61c46ed4b186f26d5133dab_opaquelocktoken: 
35019a69-7377-2545-a7fa-0f7888f6e3bc HTTP/1.1" 405 1058 "-" "git/1.6.1"
[04/Jan/2009:21:51:29 -0800] "PUT /webdav/repos/example.git/objects/7e/ 
03ccd9dcbb5a2770cc5e52aa168a97897ce01b_opaquelocktoken: 
35019a69-7377-2545-a7fa-0f7888f6e3bc HTTP/1.1" 405 1058 "-" "git/1.6.1"
[04/Jan/2009:21:51:29 -0800] "PUT /webdav/repos/example.git/objects/67/ 
d59f8095ad0b5d90b50b05634038c831871f05_opaquelocktoken: 
35019a69-7377-2545-a7fa-0f7888f6e3bc HTTP/1.1" 405 1058 "-" "git/1.6.1"
[04/Jan/2009:21:51:29 -0800] "PUT /webdav/repos/example.git/objects/ 
72/6f7925fa8539c202558d1cf7567c173fed6b42_opaquelocktoken: 
35019a69-7377-2545-a7fa-0f7888f6e3bc HTTP/1.1" 405 1058 "-" "git/1.6.1"
[04/Jan/2009:21:51:30 -0800] "UNLOCK /webdav/repos/example.git/refs/ 
heads/master HTTP/1.1" 204 - "-" "git/1.6.1"




--Apple-Mail-22--573493672
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGKzCCAuQw
ggJNoAMCAQICEHVN3dEBs1SxXdN8LoqS66EwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA4MTEwNjA3MDIxMloXDTA5MTEwNjA3MDIx
MlowRzEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEkMCIGCSqGSIb3DQEJARYVaGFy
cnkud2VwcG5lckBnbXgubmV0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmUkNeF6z
+G6UlATbBcGR7svIdL2fUkJHuw9ArDrLN6fr0aetNsNz91IVfV2QQ+7gGZjkfhE4Ri6JSKkiud9P
y4IqFfjyt9pcrBnX0HBKksXP/nDxl7rFJb32dLNy14mP01Uzbhxfu0OpxblEjpS3vD06lsGfeT8y
wjuFH9Z4i7aV8BUhc98wY9vYmwHazAlFQkEijtrwAIWn+eB1koH9r7tWMlfBrreRtBsmZhJJ+hIM
W/kamGtr8xE7dxiPd2J32IKgvhY276iU6TL0poPPCw78qyJ/CnzIUi1GTzd588DXCSbdAE6k8WgR
RUYk0AWU7c8DduFrsh2MJPL/N16suwIDAQABozIwMDAgBgNVHREEGTAXgRVoYXJyeS53ZXBwbmVy
QGdteC5uZXQwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQUFAAOBgQA0cAxscUPhcj44GN9CIQyW
gt0SMwzQFq8gXaADgxXfoDQ6Fg+WD5fDYsmans+gAcOSBvQCDuTYv2uK8La0hJM/yzO3zZSsGFQs
cL/jwer9qTNVLGHS3S1OoTGZpYK+3GTtwCn/orMXaDkFP+gtcbBAxl7Zky9vShf2+oCEqHQb2TCC
Az8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxX
ZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRp
bmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1Ro
YXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1h
aWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYT
AlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3
dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkC
gYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkV
cI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUP
SAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCBkTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8
MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhhd3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0Eu
Y3JsMAsGA1UdDwQEAwIBBjApBgNVHREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0x
MzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2f
Ni/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH
1sYITq726jTlEBpbNU1341YheILcIRk13iSx0x1G/11fZU8xggMQMIIDDAIBATB2MGIxCzAJBgNV
BAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQdU3d0QGzVLFd03wuipLroTAJBgUr
DgMCGgUAoIIBbzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wOTAx
MDUwNjI2MTdaMCMGCSqGSIb3DQEJBDEWBBTXQmnt268ShnNpvhG8kMFjbtr2JzCBhQYJKwYBBAGC
NxAEMXgwdjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkg
THRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEHVN3dEB
s1SxXdN8LoqS66EwgYcGCyqGSIb3DQEJEAILMXigdjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMc
VGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZy
ZWVtYWlsIElzc3VpbmcgQ0ECEHVN3dEBs1SxXdN8LoqS66EwDQYJKoZIhvcNAQEBBQAEggEAPVvg
nCbmgCq1akRxlQTgXsh7mF9KGiToe64Pq35IbvEMl/oS6VdaVP1xZS4jgV8eH6pGCY6aOyJcxT1Z
9YSjsIpirBTPd3qvzajpiutYoAx6dtfquJ24/U52W+/b+aczLwBe+6BO/djnJKIETCSE97tiugVD
9YrqFWBg2PsfAZtsdThZsafx0HMEbQ/E/56g0zvSx8CHW8KS26p6S9PulKWPYrgVrmi0UyLi9NOL
RaaY9vr7NI6zV9gbv9VOjufH/gGQK+tbeDuA/ji0FQSRKDCEptLb//SGbZGt5JhHhNxsVjCbW/qz
XuS720gLRiWMubyv3ayqnCzt3az1jUByFwAAAAAAAA==

--Apple-Mail-22--573493672--
