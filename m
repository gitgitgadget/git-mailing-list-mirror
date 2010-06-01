From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: Recovering from commit --amend in rebase --interactive
Date: Tue, 01 Jun 2010 11:07:38 -0400
Message-ID: <4C05223A.7000204@gmail.com>
References: <alpine.DEB.2.00.1006011022030.2352@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Jun 01 17:07:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJT4J-0007iR-DS
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 17:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755995Ab0FAPHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 11:07:46 -0400
Received: from mail-yw0-f179.google.com ([209.85.211.179]:54472 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078Ab0FAPHp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 11:07:45 -0400
Received: by ywh9 with SMTP id 9so3693381ywh.17
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=aWJ9h87mJWby2XaN/LVUJNhhHUFP+fAWbJdaPhONktY=;
        b=Vokq4nBFK4sThjMStUZFL4zi/ol4gJx9rkSqLgcOkg96fSSjuM5jjOI5LY5z0Htulb
         iMOHFlE5wsBMp/1ESL44drF44WcruGy5REWvZ0IUqUtHAGLDUBOWP+eEEFLaz8/o4Ixh
         zwYucYhKmIRXPXbM1rSSWQ7ISnCzQ2zEigUu4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=bwds7MFEHIAm2NUL6qIacGIS9u7GxIPNwJSZQOAe8dZWdST6PwXYNPMZIcCTcLqQCV
         eneSbrriuneRCAHGdbqsxwh/7r/UoCWqeqI73ErpekiJmpcUcIBwHHVauJJPIo3pHDrI
         pyJ5I4x8vG6eTQ8cubaHBk80Foyvq3OWx6GVs=
Received: by 10.42.8.69 with SMTP id h5mr5989792ich.4.1275404864471;
        Tue, 01 Jun 2010 08:07:44 -0700 (PDT)
Received: from [192.168.2.205] (dsl-149-99.aei.ca [66.36.149.99])
        by mx.google.com with ESMTPS id r12sm31679299ibi.14.2010.06.01.08.07.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 08:07:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100515 Iceowl/1.0b1 Icedove/3.0.4
In-Reply-To: <alpine.DEB.2.00.1006011022030.2352@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148123>

On 2010-06-01 05:27, Peter Krefting wrote:
> Last time this happened to me, I *did* notice my mistake as I entered
> the editor, since it came up with the previous commit's message.
> However, as the commit message file was in a good shape, I found no way
> to break out of the amend. I ended up using "git reflog" to find out
> what I overwrote, then "git diff $commitid > savedpatch" to remember
> what the change that I mistakenly amended was, then "git checkout
> $commitid" and "git apply savedpatch" and "git add" on the changed
> files. What I am wondering if there is an easier way of recovering?
> 

when you amend or rebase commits, the "old" commits are still in your
local git repository as long as you don't "git gc" them. for this, the
reflog can help you find the previous sha1 for the old commit. you can
also use "git fsck --full" to find out which commits were orphaned. once
you have the hashes, you can bring HEAD back to them.

see [1] for some simple examples of data recovery with git.

[1]:http://progit.org/book/ch9-7.html#data_recovery

-- 
Gabriel Filion
