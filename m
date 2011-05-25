From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Merge made by recursive?
Date: Wed, 25 May 2011 11:04:05 -0700 (PDT)
Message-ID: <m339k2zmh8.fsf@localhost.localdomain>
References: <loom.20110525T192418-887@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shawn Ligocki <sligocki@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 20:04:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPIRM-0005AR-2w
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 20:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791Ab1EYSEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 14:04:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44033 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023Ab1EYSEI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 14:04:08 -0400
Received: by fxm17 with SMTP id 17so5548812fxm.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=KEU6eSV9pTfnLoodNA0/TDqfbFjwIi2RvAYv97zOoWc=;
        b=u6JQnZCDpEZRLuEgwBuHOtxtNqqum1z7Bu/+hmuOAFPjsFb31ZskY64NM9Mp6K8ueZ
         9vnf7cduOmEiB9eRucU82Sf9EEQGGqAOEYJBtCz2iPWDefaC4vLDDch5SWyVFJoWxn/X
         YVRnHpVxaIP/gwW++N0M10PvPn7mFbgVtHEPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=F7hURTUBtQxzRXBeZjCfF8QggYON2B02THiLN2DxgLjrOFDvA4iU2FGx4Vv9ClgyYC
         dO5W4d9XHQQO9wdZsXI4yF3vWSXOUntmrgZb/8wA6Pf3f9bgyI4Czrd+6Yd2crGb0O/E
         02At5177rMKZ32FbBDNX7OEonim6QkRpOQxNA=
Received: by 10.223.63.147 with SMTP id b19mr70360fai.114.1306346646948;
        Wed, 25 May 2011 11:04:06 -0700 (PDT)
Received: from localhost.localdomain (abvv43.neoplus.adsl.tpnet.pl [83.8.219.43])
        by mx.google.com with ESMTPS id d14sm316866fan.12.2011.05.25.11.04.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 11:04:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p4PI3inE012417;
	Wed, 25 May 2011 20:03:54 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p4PI3VwG012410;
	Wed, 25 May 2011 20:03:31 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <loom.20110525T192418-887@post.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174441>

Shawn Ligocki <sligocki@gmail.com> writes:

> Is this intentionally bad grammar? Every time I see it, I cringe a little. What 
> does it even mean? That it merged incrementally through each subsequent revision?

"Merge made by recursive" means "Merge made by 'recursive' merge strategy",
where 'recursive' part refers to the fact that in case of criss-cross
merge

        /--*---B1---M1---*---#  <-- foo
       /        \  /
   ---B           x
       \         / \
        \--*---B2---M2---*---#  <-- bar

(you are trying to merge 'bar' into 'foo') when we have more than one
merge base, the strategy first creates synthetic merge for B1 and B2


                    M1---*---#  <-- foo
                   /
                  X
                   \
                    M2---*---#  <-- bar

and uses this X as a merge base for further merging.  Or something
like that.

See "Merge strategies" section in git-merge(1) documentation.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
