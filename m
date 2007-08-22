From: Salikh Zakirov <salikh@gmail.com>
Subject: [packaging] binary Gentoo/x86 ebuild for M2 snapshot
Date: Thu, 23 Aug 2007 00:26:23 +0900
Message-ID: <fahkjo$esh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040303070309050607070304"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 17:27:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INs6w-0000wn-Gp
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 17:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762810AbXHVP1F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 11:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759356AbXHVP1F
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 11:27:05 -0400
Received: from main.gmane.org ([80.91.229.2]:53775 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758077AbXHVP1D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 11:27:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INs6k-0000hu-2K
	for git@vger.kernel.org; Wed, 22 Aug 2007 17:26:58 +0200
Received: from cerberus.is.titech.ac.jp ([131.112.51.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 17:26:58 +0200
Received: from salikh by cerberus.is.titech.ac.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 17:26:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cerberus.is.titech.ac.jp
User-Agent: Thunderbird 2.0.0.6 (X11/20070819)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56389>

This is a multi-part message in MIME format.
--------------040303070309050607070304
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I've tried to create a binary package descriptor of M2 stable snapshot for Gentoo/x86
(as it is simpler than building from source, and the source snapshot is not available anyway).
It seems to install and work nicely, at least I am now trying to run the build process using
harmony jre, and it hasn't failed yet. I will see how long I can use it :)

Instruction on how to try out:

0) configure portage overlay

	$ echo 'PORTDIR_OVERLAY="/usr/local/portage"' >> /etc/make.conf

1) put the ebuild files in place

	$ mkdir -p /usr/local/portage/dev-java/harmony-jre-bin/files
	$ mv harmony-jre-bin-0.02.ebuild /usr/local/portage/dev-java/harmony-jre-bin
	$ mv harmony-jre-bin.env /usr/local/portage/dev-java/harmony-jre-bin/files

2) regenerate the ebuild manifest and digest files

	$ ebuild /usr/local/portage/dev-java/harmony-jre-bin/harmony-jre-bin-0.02.ebuild digest

3) configure keywords to accept unstable package

	$ echo 'dev-java/harmony-jre-bin ~x86' >> /etc/portage/package.keywords

4) install the package
	
	$ emerge harmony-jre-bin

5) make sure that the harmony-jre is in the list of installed VMs, and choose it as default

	$ java-config -L
	$ java-config --set-system-vm=harmony-jre-bin
	$ java -version



Some questions

Where would be the best to check in the Gentoo ebuild files?


Minor nits, that can confuse potential end users

1) ant complains that it cannot find tools.jar
This is probably because it is JRE snapshot rather than JDK

2) each run java prints
'The GC did not provide gc_add_weak_root_set_entry()'
This is trivial issue, and AFAIK weak root support is scheduled for GC_v5,
but anyway, we'd better make sure such trivial issues are fixed in packaged builds.

3) 'java -version' output is somewhat noisy, and has some not-to-the-point information,
e.g. end user is unlikely to want to know that launcher is separate component in Harmony

4) Gentoo is not keen to have a version identifier 'M2', so I changed it to '0.02'. It would be nice
if our release numbering would be compatible with packaging systems without such changes,
to reduce confusion.

--------------040303070309050607070304
Content-Type: text/plain;
 name="harmony-jre-bin-0.02.ebuild"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="harmony-jre-bin-0.02.ebuild"

IyBpbiBwdWJsaWMgZG9tYWluCgppbmhlcml0IGphdmEtdm0tMgoKREVTQ1JJUFRJT049Ikph
dmEgU0UgNSBKREsgdW5kZXIgdGhlIEFwYWNoZSBMaWNlbnNlIHYyIgoKSE9NRVBBR0U9Imh0
dHA6Ly9oYXJtb255LmFwYWNoZS5vcmciClNSQ19VUkk9Imh0dHA6Ly9wZW9wbGUuYXBhY2hl
Lm9yZy9idWlsZHMvaGFybW9ueS9taWxlc3RvbmVzL00yL2FwYWNoZS1oYXJtb255LWpyZS1y
NTUxMDc3LWxpbnV4LXg4Ni0zMi1zbmFwc2hvdC50YXIuZ3oiCgpMSUNFTlNFPSJBcGFjaGUt
MiIKU0xPVD0iMCIKS0VZV09SRFM9Ii0qIH54ODYiCklVU0U9IiIKCkRFUEVORD0iIgpSREVQ
RU5EPSIiCgpzcmNfdW5wYWNrKCkgewoJdGFyIHhmeiAiJHtESVNURElSfS8ke0F9Igp9Cgpz
cmNfaW5zdGFsbCgpIHsKCWRvZGlyICIvb3B0LyR7UH0iCgljcCAtYSAiJHtXT1JLRElSfSIv
aGFybW9ueS1qcmUtKi8qICIke0R9L29wdC8ke1B9IgoKCSMgY3JlYXRlIHRoZSBWTSBoYW5k
bGUgZmlsZSBpbiAvdXNyL3NoYXJlL2phdmEtY29uZmlnLTIvdm0KCXNldF9qYXZhX2Vudgp9
Cgpwa2dfcG9zdGluc3QoKSB7CglqYXZhLXZtLTJfcGtnX3Bvc3RpbnN0Cn0K
--------------040303070309050607070304
Content-Type: text/plain;
 name="harmony-jre-bin.env"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="harmony-jre-bin.env"

IyBpbiBwdWJsaWMgZG9tYWluCgpWRVJTSU9OPSJBcGFjaGUgSGFybW9ueSBKUkUgQFBWQCIK
SkFWQV9IT01FPS9vcHQvQFBAClBBVEg9IiR7SkFWQV9IT01FfS9iaW4iClBST1ZJREVTX1RZ
UEU9IkpSRSIKUFJPVklERVNfVkVSU0lPTj0iMS41IgpHRU5FUkFUSU9OPSIyIgpFTlZfVkFS
Uz0iSkFWQV9IT01FIFBBVEgiCg==
--------------040303070309050607070304--
