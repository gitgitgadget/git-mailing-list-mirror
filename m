From: Juan Palacios <jpalacios@atlassian.com>
Subject: Bug Report: Submodule conflict error message
Date: Fri, 24 Oct 2014 13:46:51 +1100
Message-ID: <CABY2JrJBgFDP-gKWUR438PiuB+g0g2wrD9Hoa-fkfCUyUaGp6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1139f63e7169d00506223101
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 04:47:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhUu5-0006JK-VM
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 04:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbaJXCqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 22:46:53 -0400
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:60921 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751700AbaJXCqx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Oct 2014 22:46:53 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]) (using TLSv1) by na3sys009aob106.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVEm9nCNgJ04vA07VwewSHxjuyF6PdKSm@postini.com; Thu, 23 Oct 2014 19:46:52 PDT
Received: by mail-yh0-f47.google.com with SMTP id c41so2158826yho.6
        for <git@vger.kernel.org>; Thu, 23 Oct 2014 19:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=ijTves+EsWg3pwDQ/0iTO05XudVli9MbCQ0p83TC4jc=;
        b=MIgUrIE33cKKEgp1rSWul77gS/H5zM5yxcgeOukg7lGnDIWYE/Sty00mODKU/fUVjd
         rUubkWEXxmGifVQBRu/eSD/FWtp+RdjSq91TeMvsToytKjKR3hxjjvFXYiEOk5ZvP9e3
         Wvjjx9f8VwgcfLQQGPiPSg7KvgQJwqJ1s0UCQJPMWWGjvrJdNd2JoRYFyg2aGfzet+cY
         6GcbpEjzqnO4CCOurLSoEDZLvJNZ85ZaqOXiIs05UR1RccWOpkRh0CnsvEkQofSb06zd
         d36IgfuKpHVz/ZMo58j07XkjFttZ481VAB8YR92FOOxyvSiMci+Ul3XlqtIJyv0JgNxI
         TpCA==
X-Received: by 10.170.127.8 with SMTP id t8mr1761070ykb.86.1414118811830;
        Thu, 23 Oct 2014 19:46:51 -0700 (PDT)
X-Gm-Message-State: ALoCoQlJ6DEbLJDaNqTZvj+QdTC1JUWYZCGz5bNhbM/ALuCygzbvEn1yl4BWHM0TviVgZ/8JG5EaCuqamR8IQacg6594TwIRNWC+iVAdnVteM043cSl05LVg6vUZV91wdwUzar77ngMO9Pg8mulGal9Pra3ps1VPzA==
X-Received: by 10.170.127.8 with SMTP id t8mr1761049ykb.86.1414118811648; Thu,
 23 Oct 2014 19:46:51 -0700 (PDT)
Received: by 10.50.221.180 with HTTP; Thu, 23 Oct 2014 19:46:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a1139f63e7169d00506223101
Content-Type: text/plain; charset=UTF-8

In a project with a submodule, if you merge two diverging branches in
which one branch updated which commit the submodule points to, and the
other branch moves the submodule to a new location, the resulting
merge error message does not provide information about what the
conflict was, or the path to the conflicted directory.

I've attached a short script which sets up a project with a submodule
and creates both branches. If after running it you cd into
'top-level-project' and run 'git merge
branch_that_points_the_submodule_to_new_commit' the resulting error
message is:

Auto-merging submodule-moved
Adding as submodule-moved~HEAD instead
Automatic merge failed; fix conflicts and then commit the result.

I would have expected an output in line with other merge conflict
messages. Something with the format:

CONFLICT (<REASON>): Merge conflict in <PATH_TO_CONFLICT>

Where <REASON> would be something like (delete/modify) I believe this
might be a bug in the implementation.

Thank you

--001a1139f63e7169d00506223101
Content-Type: application/x-sh; name="submodule-conflict.sh"
Content-Disposition: attachment; filename="submodule-conflict.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i1mxtel30

IyEvdXNyL2Jpbi9lbnYgYmFzaAoKIyBDcmVhdGUgYSBzdWJtb2R1bGUKbWtkaXIgc3VibW9kdWxl
CnB1c2hkIHN1Ym1vZHVsZQplY2hvICJUaGlzIGlzIGEgc3VibW9kdWxlIiA+IFJFQURNRS50eHQK
Z2l0IGluaXQKZ2l0IGFkZCBSRUFETUUudHh0IApnaXQgY29tbWl0IC1tICJJbml0aWFsIGNvbW1p
dCIKcG9wZAoKIyBDcmVhdGUgYSB0b3AgbGV2ZWwgcHJvamVjdApta2RpciB0b3AtbGV2ZWwtcHJv
amVjdApwdXNoZCB0b3AtbGV2ZWwtcHJvamVjdAplY2hvICJUaGlzIGlzIGEgcGFyZW50IHByb2pl
Y3QiID4gUkVBRE1FLnR4dApnaXQgaW5pdApnaXQgYWRkIFJFQURNRS50eHQKZ2l0IGNvbW1pdCAt
bSAiSW5pdGlhbCBjb21taXQiCgojIEFkZCBzdWJtb2R1bGUgdG8gdG9wIGxldmVsIHByb2plY3QK
Z2l0IHN1Ym1vZHVsZSBhZGQgLi4vc3VibW9kdWxlLwpnaXQgY29tbWl0IC1tICJBZGRlZCBhIHN1
Ym1vZHVsZSIKCiMgQ3JlYXRlIHR3byBkaXZlcmdpbmcgYnJhbmNoZXMKZ2l0IGNoZWNrb3V0IC1i
IGJyYW5jaF90aGF0X3BvaW50c190aGVfc3VibW9kdWxlX3RvX25ld19jb21taXQKZ2l0IGNoZWNr
b3V0IC1iIGJyYW5jaF90aGF0X21vdmVzX3RoZV9zdWJtb2R1bGVfdG9fbmV3X3BhdGgKCiMgVXBk
YXRlIHRoZSBjb21taXQgdGhlIHN1Ym1vZHVsZSBwb2ludHMgdG8gaW4gb25lIGJyYW5jaApnaXQg
Y2hlY2tvdXQgYnJhbmNoX3RoYXRfcG9pbnRzX3RoZV9zdWJtb2R1bGVfdG9fbmV3X2NvbW1pdApw
dXNoZCBzdWJtb2R1bGUKZWNobyAiVGhpcyBtb2RpZmllcyB0aGUgUkVBRE1FIGZpbGUiID4gUkVB
RE1FLnR4dCAKZ2l0IGFkZCAuCmdpdCBjb21taXQgLW0gIkFkZGVkIGxpbmUgdG8gUkVBRE1FIGZp
bGUiCnBvcGQKZ2l0IGFkZCBzdWJtb2R1bGUKZ2l0IGNvbW1pdCAtbSAiVXBkYXRlZCBzdWJtb2R1
bGUgdG8gcG9pbnQgdG8gbmV3IGNvbW1pdCIKCiMgTW92ZSB0aGUgc3VibW9kdWxlIGRpcmVjdG9y
eSBpbiB0aGUgb3RoZXIgYnJhbmNoCmdpdCBjaGVja291dCBicmFuY2hfdGhhdF9tb3Zlc190aGVf
c3VibW9kdWxlX3RvX25ld19wYXRoCmdpdCBzdWJtb2R1bGUgdXBkYXRlCmdpdCBtdiBzdWJtb2R1
bGUgc3VibW9kdWxlLW1vdmVkCmdpdCBjb21taXQgLW0gIk1vdmVkIHN1Ym1vZHVsZSB0byBuZXcg
cGF0aCIK
--001a1139f63e7169d00506223101--
