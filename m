From: adatoccpptranslator@free.fr
Subject: Issue when merging a subtree whose a file has been removed
Date: Thu, 21 May 2015 14:44:35 +0200 (CEST)
Message-ID: <617623154.419127148.1432212275021.JavaMail.root@zimbra41-e7.priv.proxad.net>
References: <1663657179.419121722.1432212216042.JavaMail.root@zimbra41-e7.priv.proxad.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_419127144_1341327900.1432212275018"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 14:44:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvPqE-0001sU-8Q
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 14:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbbEUMop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 08:44:45 -0400
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:49560 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231AbbEUMoo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 08:44:44 -0400
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 809EB77D4EF
	for <git@vger.kernel.org>; Thu, 21 May 2015 14:44:40 +0200 (CEST)
Received: from zimbra41-e7.priv.proxad.net (unknown [172.20.243.191])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 1D0659400CC
	for <git@vger.kernel.org>; Thu, 21 May 2015 14:41:11 +0200 (CEST)
In-Reply-To: <1663657179.419121722.1432212216042.JavaMail.root@zimbra41-e7.priv.proxad.net>
X-Originating-IP: [164.129.115.76, 77.242.202.228]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Win)/7.2.0-GA2598)
X-Authenticated-User: adatoccpptranslator@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269580>

------=_Part_419127144_1341327900.1432212275018
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi all,

 

I want to use subtrees in one of my projects and I use method desribed here https://git-scm.com/book/en/v1/Git-Tools-Subtree-Merging
I`m facing issues when merging subtree in my subproject in case some files have been removed from the subtree.

I`m running git 1.9.1 on Kubuntu  14.04
sub_project is integrated as subtree in my main project. I modify a file and remove an other file from my sub_project, commit the modification, go in my main_project, checkout the sub_project integration branch, pull the modification.
I see the modification of the modified file and the deletion of the removed file 
I checkout the master branch of my main project.
git diff-tree -p sub_project_branch indicate that one file has been modified and one files has been deleted
then I perform a merge of my subtree integration branch into master branch.

I was expecting to see the in master the modification of the file and the deletion of the other file but the removed file is still there and tracked. The modification of file has been done but It looks like the deletion has not been "merged".
The test case can be reproduced using run_subtree.sh attached script 

The behaviour I expect is the same that the one illustrated in run.sh which perform exactly the same actions excepted they are done in a branch instead of a subtree:
toto should have been modified, tata should no more be there or at least no more be tracked

According to what I see it seems that the subtree merge is doing a kind of copy instead of a real merge meaning that if source file disappear then the corresponding target file is untouched instead of being deleted.
Is this behaviour correct or is it my understanding of what subtree merge should do that is wrong ?


Thanks by advance
Julien

PS : as my subtree prefix has 2 levels I also test with a single level like in subtree tutorial to ensure this was not the cause of my issue but the problem remains the same. the single level test is performed by run_simple_subtree.sh
------=_Part_419127144_1341327900.1432212275018
Content-Type: application/x-shellscript; name=run.sh
Content-Disposition: attachment; filename=run.sh
Content-Transfer-Encoding: base64

IyEvYmluL3NoCmdpdCBpbml0CnRvdWNoIHRvdG8KZWNobyAiLS0tLS0tLS0tLS0tLS0tLS0iID4+
IHRvdG8KZWNobyAiLSB0b3RvIGZpbGUiPj4gdG90bwplY2hvICItLS0tLS0tLS0tLS0tLS0tLSIg
Pj4gdG90bwp0b3VjaCB0YXRhCmVjaG8gIi0tLS0tLS0tLS0tLS0tLS0tIiA+PiB0YXRhCmVjaG8g
Ii0gdGF0YSBmaWxlIj4+IHRhdGEKZWNobyAiLS0tLS0tLS0tLS0tLS0tLS0iID4+IHRhdGEKZ2l0
IGFkZCB0b3RvIHRhdGEKZ2l0IGNvbW1pdCAtbSAiSW5pdGlhbCBjb21taXQiCmVjaG8gImVjaG8g
dG90byIgPj4gdG90bwplY2hvICJlY2hvIHRhdGEiID4+IHRhdGEKZ2l0IGNvbW1pdCAtYW0gIkFk
ZCBjb250ZW50IHRvIGZpbGUiCmdpdCBjaGVja291dCAtYiBoZWFkZXJzCmVjaG8gIiNFT0YiID4+
IHRvdG8KZ2l0IGFkZCB0b3RvCmdpdCBybSB0YXRhCmdpdCBjb21taXQgLW0gIkFkZCBFT0YgYW5k
IHJlbW92ZSB0YXRhIgpnaXQgY2hlY2tvdXQgbWFzdGVyCnRvdWNoIHR1dHUKZWNobyAiLS0tLS0t
LS0tLS0tLS0tLS0iID4+IHR1dHUKZWNobyAiLSB0dXR1IGZpbGUiPj4gdHV0dQplY2hvICItLS0t
LS0tLS0tLS0tLS0tLSIgPj4gdHV0dQpnaXQgYWRkIHR1dHUKZ2l0IGNvbW1pdCAtbSAiQWRkIHR1
dHUgZmlsZSIKZ2l0IG1lcmdlIC1tICJNZXJnZSBmcm9tIGhlYWRlcnMgYnJhbmNoIiBoZWFkZXJz
CmVjaG8gIiNFT0YiID4+IHR1dHUKZ2l0IGFkZCB0dXR1CmdpdCBjb21taXQgLW0gIkFkZCBFT0Yi
CmdpdCBzdGF0dXMKbHMKI0VPRgoKCg==
------=_Part_419127144_1341327900.1432212275018
Content-Type: application/x-shellscript; name=run_subtree.sh
Content-Disposition: attachment; filename=run_subtree.sh
Content-Transfer-Encoding: base64

IyEvYmluL3NoCgojIENyZWF0aW5nIHByb2plY3QgdGhhdCB3aWxsIGJlIHVzZWQgYXMgc3VidHJl
ZQpta2RpciBzdWJfcHJvamVjdApjZCBzdWJfcHJvamVjdApnaXQgaW5pdAp0b3VjaCB0b3RvCmVj
aG8gIi0tLS0tLS0tLS0tLS0tLS0tIiA+PiB0b3RvCmVjaG8gIi0gdG90byBmaWxlIj4+IHRvdG8K
ZWNobyAiLS0tLS0tLS0tLS0tLS0tLS0iID4+IHRvdG8KdG91Y2ggdGF0YQplY2hvICItLS0tLS0t
LS0tLS0tLS0tLSIgPj4gdGF0YQplY2hvICItIHRhdGEgZmlsZSI+PiB0YXRhCmVjaG8gIi0tLS0t
LS0tLS0tLS0tLS0tIiA+PiB0YXRhCmdpdCBhZGQgdG90byB0YXRhCmdpdCBjb21taXQgLW0gIklu
aXRpYWwgY29tbWl0IgplY2hvICJlY2hvIHRvdG8iID4+IHRvdG8KZWNobyAiZWNobyB0YXRhIiA+
PiB0YXRhCmdpdCBjb21taXQgLWFtICJBZGQgY29udGVudCB0byBmaWxlIgpjZCAuLgoKIyBDcmVh
dGluZyBtYWluIHByb2plY3QgdGhhdCB3aWxsIHVzZSB0aGUgc3VidHJlZQpta2RpciBtYWluX3By
b2plY3QKY2QgbWFpbl9wcm9qZWN0CmdpdCBpbml0CnRvdWNoIHR1dHUKZWNobyAiLS0tLS0tLS0t
LS0tLS0tLS0iID4+IHR1dHUKZWNobyAiLSB0dXR1IGZpbGUiPj4gdHV0dQplY2hvICItLS0tLS0t
LS0tLS0tLS0tLSIgPj4gdHV0dQpnaXQgYWRkIHR1dHUKZ2l0IGNvbW1pdCAtbSAiQWRkIHR1dHUg
ZmlsZSIKIyBDcmVhdGlvbiBvZiBzdWJ0cmVlCm1rZGlyIHNvdXJjZXMKZ2l0IHJlbW90ZSBhZGQg
c3ViX3Byb2plY3RfcmVtb3RlIC4uL3N1Yl9wcm9qZWN0CmdpdCBmZXRjaCBzdWJfcHJvamVjdF9y
ZW1vdGUKZ2l0IGNoZWNrb3V0IC1iIHN1Yl9wcm9qZWN0X2JyYW5jaCBzdWJfcHJvamVjdF9yZW1v
dGUvbWFzdGVyCmdpdCBjaGVja291dCBtYXN0ZXIKZ2l0IHJlYWQtdHJlZSAtLXByZWZpeD1zb3Vy
Y2VzL3N1Yl9wcm9qZWN0LyAtdSBzdWJfcHJvamVjdF9icmFuY2gKZ2l0IGNvbW1pdCAtYW0gIklu
dGVncmF0aW9uIG9mIHN1YnRyZWUiCgplY2hvICItLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0iCmVj
aG8gIlN1YnRyZWUgd2VsbCBpbnRlZ3JhdGVkICIKbHMgKgpscyBzb3VyY2VzL3N1Yl9wcm9qZWN0
CmVjaG8gIi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSIKCiMgR28gaW4gc3VidHJlZSB0byByZW1v
dmUgdGF0YSBmaWxlCmNkIC4uL3N1Yl9wcm9qZWN0CmVjaG8gIiNFT0YiID4+IHRvdG8KZ2l0IGFk
ZCB0b3RvCmdpdCBybSB0YXRhCmdpdCBjb21taXQgLW0gIkFkZCBFT0YgYW5kIHJlbW92ZSB0YXRh
IgoKIyBnbyBiYWNrIGluIG1haW4gcHJvamVjdCB0byBpbnRlZ3JhdGUgc3VidHJlZSBtb2RpZmlj
YXRpb25zCmNkIC4uL21haW5fcHJvamVjdApnaXQgY2hlY2tvdXQgc3ViX3Byb2plY3RfYnJhbmNo
CmdpdCBmZXRjaCBzdWJfcHJvamVjdF9yZW1vdGUKZ2l0IHB1bGwKCmVjaG8gIi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLSIKZWNobyAiQ2hlY2sgdGhhdCB0YXRhIGhhcyBiZWVuIHJlbW92ZWQgIgps
cyAqCmVjaG8gIi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSIKCmdpdCBjaGVja291dCBtYXN0ZXIK
Z2l0IGRpZmYtdHJlZSAtcCBzdWJfcHJvamVjdF9icmFuY2gKZ2l0IG1lcmdlIC12IC0tc3F1YXNo
IC0tbm8tY29tbWl0IC1YIHN1YnRyZWU9c291cmNlcy9zdWJfcHJvamVjdCAtWCB0aGVpcnMgc3Vi
X3Byb2plY3RfYnJhbmNoCgplY2hvICItLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0iCmVjaG8gIkNo
ZWNrIGFmdGVyIG1lcmdlIHRoYXQgdGF0YSBoYXMgYmVlbiByZW1vdmVkICIKbHMgc291cmNlcy8q
CmVjaG8gIi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSIKZ2l0IGNvbW1pdCAtbSAiU2Vjb25kIGlu
dGVncmF0aW9uIGZyb20gc3VidHJlZSIKY2QgLi4KI0VPRg==
------=_Part_419127144_1341327900.1432212275018
Content-Type: application/x-shellscript; name=run_simple_subtree.sh
Content-Disposition: attachment; filename=run_simple_subtree.sh
Content-Transfer-Encoding: base64

IyEvYmluL3NoCgojIENyZWF0aW5nIHByb2plY3QgdGhhdCB3aWxsIGJlIHVzZWQgYXMgc3VidHJl
ZQpta2RpciBzdWJfcHJvamVjdApjZCBzdWJfcHJvamVjdApnaXQgaW5pdAp0b3VjaCB0b3RvCmVj
aG8gIi0tLS0tLS0tLS0tLS0tLS0tIiA+PiB0b3RvCmVjaG8gIi0gdG90byBmaWxlIj4+IHRvdG8K
ZWNobyAiLS0tLS0tLS0tLS0tLS0tLS0iID4+IHRvdG8KdG91Y2ggdGF0YQplY2hvICItLS0tLS0t
LS0tLS0tLS0tLSIgPj4gdGF0YQplY2hvICItIHRhdGEgZmlsZSI+PiB0YXRhCmVjaG8gIi0tLS0t
LS0tLS0tLS0tLS0tIiA+PiB0YXRhCmdpdCBhZGQgdG90byB0YXRhCmdpdCBjb21taXQgLW0gIklu
aXRpYWwgY29tbWl0IgplY2hvICJlY2hvIHRvdG8iID4+IHRvdG8KZWNobyAiZWNobyB0YXRhIiA+
PiB0YXRhCmdpdCBjb21taXQgLWFtICJBZGQgY29udGVudCB0byBmaWxlIgpjZCAuLgoKIyBDcmVh
dGluZyBtYWluIHByb2plY3QgdGhhdCB3aWxsIHVzZSB0aGUgc3VidHJlZQpta2RpciBtYWluX3By
b2plY3QKY2QgbWFpbl9wcm9qZWN0CmdpdCBpbml0CnRvdWNoIHR1dHUKZWNobyAiLS0tLS0tLS0t
LS0tLS0tLS0iID4+IHR1dHUKZWNobyAiLSB0dXR1IGZpbGUiPj4gdHV0dQplY2hvICItLS0tLS0t
LS0tLS0tLS0tLSIgPj4gdHV0dQpnaXQgYWRkIHR1dHUKZ2l0IGNvbW1pdCAtbSAiQWRkIHR1dHUg
ZmlsZSIKIyBDcmVhdGlvbiBvZiBzdWJ0cmVlCmdpdCByZW1vdGUgYWRkIHN1Yl9wcm9qZWN0X3Jl
bW90ZSAuLi9zdWJfcHJvamVjdApnaXQgZmV0Y2ggc3ViX3Byb2plY3RfcmVtb3RlCmdpdCBjaGVj
a291dCAtYiBzdWJfcHJvamVjdF9icmFuY2ggc3ViX3Byb2plY3RfcmVtb3RlL21hc3RlcgpnaXQg
Y2hlY2tvdXQgbWFzdGVyCmdpdCByZWFkLXRyZWUgLS1wcmVmaXg9c3ViX3Byb2plY3QvIC11IHN1
Yl9wcm9qZWN0X2JyYW5jaApnaXQgY29tbWl0IC1hbSAiSW50ZWdyYXRpb24gb2Ygc3VidHJlZSIK
CmVjaG8gIi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSIKZWNobyAiU3VidHJlZSB3ZWxsIGludGVn
cmF0ZWQgIgpscyAqCmxzIHN1Yl9wcm9qZWN0CmVjaG8gIi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSIKCiMgR28gaW4gc3VidHJlZSB0byByZW1vdmUgdGF0YSBmaWxlCmNkIC4uL3N1Yl9wcm9qZWN0
CmVjaG8gIiNFT0YiID4+IHRvdG8KZ2l0IGFkZCB0b3RvCmdpdCBybSB0YXRhCmdpdCBjb21taXQg
LW0gIkFkZCBFT0YgYW5kIHJlbW92ZSB0YXRhIgoKIyBnbyBiYWNrIGluIG1haW4gcHJvamVjdCB0
byBpbnRlZ3JhdGUgc3VidHJlZSBtb2RpZmljYXRpb25zCmNkIC4uL21haW5fcHJvamVjdApnaXQg
Y2hlY2tvdXQgc3ViX3Byb2plY3RfYnJhbmNoCmdpdCBmZXRjaCBzdWJfcHJvamVjdF9yZW1vdGUK
Z2l0IHB1bGwKCmVjaG8gIi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSIKZWNobyAiQ2hlY2sgdGhh
dCB0YXRhIGhhcyBiZWVuIHJlbW92ZWQgIgpscyAqCmVjaG8gIi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSIKCmdpdCBjaGVja291dCBtYXN0ZXIKZ2l0IGRpZmYtdHJlZSAtcCBzdWJfcHJvamVjdF9i
cmFuY2gKZ2l0IG1lcmdlIC12IC0tc3F1YXNoIC0tbm8tY29tbWl0IC1zIHN1YnRyZWUgLVggdGhl
aXJzIHN1Yl9wcm9qZWN0X2JyYW5jaAoKZWNobyAiLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIgpl
Y2hvICJDaGVjayBhZnRlciBtZXJnZSB0aGF0IHRhdGEgaGFzIGJlZW4gcmVtb3ZlZCAiCmxzICoK
ZWNobyAiLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIgpnaXQgY29tbWl0IC1tICJTZWNvbmQgaW50
ZWdyYXRpb24gZnJvbSBzdWJ0cmVlIgpjZCAuLgojRU9GCg==
------=_Part_419127144_1341327900.1432212275018--
