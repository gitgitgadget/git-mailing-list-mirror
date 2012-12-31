From: =?ISO-8859-1?Q?Gr=E9gory_Pakosz?= <gpakosz@visionobjects.com>
Subject: git filter-branch doesn't dereference annotated tags
Date: Mon, 31 Dec 2012 15:36:16 +0100
Message-ID: <CAC_01E3a5Bwb-KjJs+wvb6rO_A1OyDrzBRRetC0tPxUADMhYrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec53aedb4c4a2bf04d226f0ec
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 31 15:52:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpgit-0000qB-GH
	for gcvg-git-2@plane.gmane.org; Mon, 31 Dec 2012 15:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283Ab2LaOv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 09:51:56 -0500
Received: from mail.elysmail.net ([188.165.34.231]:50982 "EHLO elysmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235Ab2LaOvy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 09:51:54 -0500
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Dec 2012 09:51:54 EST
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=visionobjects.com; s=vo2010objects;
        h=received:received:received:mime-version:received:from:date
          :message-id:subject:to:content-type:x-declude-sender
          :x-declude-spoolname:x-declude-refid:x-declude-note
          :x-declude-scan:x-declude-tests:x-country-chain:x-declude-code
          :x-helo:x-identity;
        b=X0L6Ypbz+0Y/pQsPf+3jHlPEV0ZU0gvB1vbVW0/kj7fvM8ACXiG9pH9l8DdDHyZVW
          pRz3L4SUmKPx58enthKfx/VSB0zOIrkSira1aSyv4MTem6rTGnc2lJ3ht0Yvq/jkv
          5RR7i4MaG5/92c3A7cLBHiPZh+GVY71ThwvNLR8d0=
Received: from mail-vb0-f46.google.com (mail-vb0-f46.google.com [209.85.212.46]) by elysmail.net with SMTP;
   Mon, 31 Dec 2012 15:36:36 +0100
Received: by mail-vb0-f46.google.com with SMTP id b13so12572991vby.19
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 06:36:36 -0800 (PST)
Received: by 10.52.156.40 with SMTP id wb8mr56034920vdb.39.1356964596851; Mon,
 31 Dec 2012 06:36:36 -0800 (PST)
Received: by 10.52.65.233 with HTTP; Mon, 31 Dec 2012 06:36:16 -0800 (PST)
X-Declude-Sender: gpakosz@visionobjects.com [209.85.212.46]
X-Declude-Spoolname: 21157105.eml
X-Declude-RefID: 
X-Declude-Note: Scanned by Declude 4.10.59 "http://www.declude.com/x-note.htm"
X-Declude-Scan: Outgoing Score [0] at 15:36:39 on 31 Dec 2012
X-Declude-Tests: Whitelisted
X-Country-Chain: 
X-Declude-Code: 0
X-HELO: mail-vb0-f46.google.com
X-Identity: 209.85.212.46 |  | vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212352>

--bcaec53aedb4c4a2bf04d226f0ec
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I noticed git-filter-branch doesn't dereference annotated tags prior
to invoking git update-ref -d.

Please find a patch attached that changes the call to git update-ref:

-git update-ref -m "filter-branch: delete" -d "$ref" $sha1
+git update-ref -m "filter-branch: delete" -d $(git rev-parse --verify
"$ref^{commit}") $sha1

Regards,
Gregory

--bcaec53aedb4c4a2bf04d226f0ec
Content-Type: application/octet-stream; 
	name="0001-git-filter-branch-Dereference-annotated-tags-upon-de.patch"
Content-Disposition: attachment; 
	filename="0001-git-filter-branch-Dereference-annotated-tags-upon-de.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hbdpm83f0

RnJvbSBjZWU1NDYyZjI2YmJiMjgwZjQ3MWJhMTIyMDM5ODkyNGJmZDRiZmQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHcmVnb3J5IFBha29zeiA8Z3Bha29zekB2aXNpb25vYmplY3Rz
LmNvbT4KRGF0ZTogTW9uLCAzMSBEZWMgMjAxMiAxNTozMDozNiArMDEwMApTdWJqZWN0OiBbUEFU
Q0hdIGdpdC1maWx0ZXItYnJhbmNoOiBEZXJlZmVyZW5jZSBhbm5vdGF0ZWQgdGFncyB1cG9uIGRl
bGV0aW9uCgpnaXQtZmlsdGVyLWJyYW5jaCBkaWRuJ3QgZGVyZWZlcmVuY2UgYW5ub3RhdGVkIHRh
Z3MgdXBvbiBkZWxldGlvbiB3aGljaCBtYWRlCmdpdC11cGRhdGUtcmVmIC1kIHVuaGFwcHkuCi0t
LQogZ2l0LWZpbHRlci1icmFuY2guc2ggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9naXQtZmlsdGVyLWJyYW5jaC5zaCBi
L2dpdC1maWx0ZXItYnJhbmNoLnNoCmluZGV4IDUzMTQyNDkuLjc3M2E5MWIgMTAwNzU1Ci0tLSBh
L2dpdC1maWx0ZXItYnJhbmNoLnNoCisrKyBiL2dpdC1maWx0ZXItYnJhbmNoLnNoCkBAIC0zODMs
NyArMzgzLDcgQEAgZG8KIAljYXNlICIkcmV3cml0dGVuIiBpbgogCScnKQogCQllY2hvICJSZWYg
JyRyZWYnIHdhcyBkZWxldGVkIgotCQlnaXQgdXBkYXRlLXJlZiAtbSAiZmlsdGVyLWJyYW5jaDog
ZGVsZXRlIiAtZCAiJHJlZiIgJHNoYTEgfHwKKwkJZ2l0IHVwZGF0ZS1yZWYgLW0gImZpbHRlci1i
cmFuY2g6IGRlbGV0ZSIgLWQgJChnaXQgcmV2LXBhcnNlIC0tdmVyaWZ5ICIkcmVmXntjb21taXR9
IikgJHNoYTEgfHwKIAkJCWRpZSAiQ291bGQgbm90IGRlbGV0ZSAkcmVmIgogCTs7CiAJJF94NDAp
Ci0tIAoxLjguMC4xCgo=
--bcaec53aedb4c4a2bf04d226f0ec--
