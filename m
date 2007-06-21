From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Strange diff behavior?
Date: Wed, 20 Jun 2007 18:02:13 -0700
Message-ID: <31e9dd080706201802h9dcbffawd82575d09e082155@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 03:02:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1B3x-0006aJ-HM
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 03:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbXFUBCQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 21:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbXFUBCQ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 21:02:16 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:3750 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbXFUBCP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 21:02:15 -0400
Received: by wr-out-0506.google.com with SMTP id q50so340576wrq
        for <git@vger.kernel.org>; Wed, 20 Jun 2007 18:02:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AaUtJM2666OLvK/kx5YhXYaRao35qk+afMn7rvwb7yMSeC0a4N93ACjwSqrrzxIYiuJd8/CpcC9zQcTqbzCN+HeLNmylyYIyiZEL5YBzOuyLc4KrC5txft5w9dVd52+8u2ptgQKdSvXe+Y6X7q1dKjfqqDWM5FX29IATm1sT+hk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jtfmpThT/Ayu7ykzS/3d4EV1yBBSGAY8oAIfXa7z/lA3Fh02xzY8cBNrixXNg7xFRfh88OlhvZuvsxyBD/8v3hC+vCAaoFjbNbfcfB13eG9oI/dk2JquSAkbSjf9abi2uXIxu4o+PLUh0y7vWK8xIOTq1qQBybKyh4WuYzrtc80=
Received: by 10.90.35.15 with SMTP id i15mr1205192agi.1182387733537;
        Wed, 20 Jun 2007 18:02:13 -0700 (PDT)
Received: by 10.90.54.18 with HTTP; Wed, 20 Jun 2007 18:02:13 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50578>

I'm pretty new to git, but I've been using it a lot recently and I'm
really liking it.

I do have a question that I'm 99% sure is a stupid one but I'd like an
answer anyway.

I recently make a few simple changes to a working directory, and
decided to do a diff before I committed it.

The results were something like the diff at the end of this email.

It seems like every change listed after the first one is meaningless.
I really think I just don't understand something about the diff
algorithm. Can someone tell my why those empty lines are recorded as
changes?

Jason

P.S. git diff --check is empty; there's no whitespace on those lines

P.P.S. The diff:

diff --git a/mac.cpp b/mac.cpp
index 02aab7b..34c510b 100644
--- a/mac.cpp
+++ b/mac.cpp
@@ -80,10 +80,10 @@ float grid::bilerp(const uVec & lower, const Vec &
inpos) const
     idx[0] += 1;
     vals[3] = (*this)(idx); // 1, 1

-    float low_val = lerp(pos[0], vals[0], vals[1]);
-    float high_val = lerp(pos[0], vals[2], vals[3]);
+    float low_val = cog::lerp(pos[0], vals[0], vals[1]);
+    float high_val = cog::lerp(pos[0], vals[2], vals[3]);

-    return lerp(pos[1], low_val, high_val);
+    return cog::lerp(pos[1], low_val, high_val);
 }

 float grid::max() const
@@ -194,7 +194,7 @@ mac_grid::mac_grid(const Vec & low, const Vec &
high, unsigned int dim) : low_bo

         for(idx[0] = (dim_-1)/4+1; idx[0] < 3*(dim_-1)/4; idx[0]++)
             cell_type(idx) = SOLID;
-
+
         for(idx[0] = 3*(dim_-1)/4+1; idx[0] < (dim_-1); idx[0]++)
             cell_type(idx) = SOLID;
     }
@@ -636,7 +636,7 @@ void mac_grid::printA(std::ostream & out)
     out << "sparse(";

     iVec idx;
-
+
     out << "[";
     for(idx[1] = 0; idx[1] < static_cast<int>(dim_); idx[1]++)
         for(idx[0] = 0; idx[0] < static_cast<int>(dim_); idx[0]++)
@@ -645,7 +645,7 @@ void mac_grid::printA(std::ostream & out)
             iVec e(idx + iVec(1, 0));
             iVec s(idx - iVec(0, 1));
             iVec n(idx + iVec(0, 1));
-
+
             if(w[0] > 0)
                 out << row_major_idx(idx, Adiag_.dim_)+1 <<",";
             if(s[1] > 0)
@@ -654,7 +654,7 @@ void mac_grid::printA(std::ostream & out)
                 out << row_major_idx(idx, Adiag_.dim_)+1 <<",";
             if(n[1] < static_cast<int>(dim_))
                 out << row_major_idx(idx, Adiag_.dim_)+1 <<",";
-
+
             out << row_major_idx(idx, Adiag_.dim_)+1 <<",";
         }

@@ -742,7 +742,7 @@ float mac_grid::dot(const grid & l, const grid & r) const
         for(idx[0] = 1; idx[0] < dim_-1; idx[0]++)
             if(cell_type(idx) == FLUID)
                 res += l(idx)*r(idx);
-
+
     return res;
 }

@@ -903,7 +903,7 @@ void mac_grid::construct_pc()
                 {
                     float sfact = Aplusj_(s)*pc_(s);
                     ichol += sfact*sfact;
-
+
                     float wfact = Aplusi_(w)*pc_(w);
                     ichol += wfact*wfact;
                 }
@@ -940,7 +940,7 @@ void mac_grid::apply_pc(const grid & rhs, grid & res)
         {
             uVec s(idx-uVec(0, 1));
             uVec w(idx-uVec(1, 0));
-
+
             float t = rhs(idx);
             if(cell_type(s) == FLUID)
                 t -= Aplusj_(s)*pc_(s)*q_(s);
