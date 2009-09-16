From: Gonsolo <gonsolo@gmail.com>
Subject: Re: Direct ancestors from commit to HEAD
Date: Wed, 16 Sep 2009 17:10:24 +0200
Message-ID: <4AB0FFE0.9040106@googlemail.com>
References: <4AB0EFC0.8020005@googlemail.com> <m3vdjj2ceq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 17:11:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnwAb-0003lO-5h
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 17:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759248AbZIPPKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 11:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759247AbZIPPKk
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 11:10:40 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:44829 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759230AbZIPPK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 11:10:27 -0400
Received: by bwz19 with SMTP id 19so3562715bwz.37
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 08:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=hlFPgEHRMQ+0664MXiXTS9H2JwBbd0xKf4WTJGMiiPI=;
        b=HWrFh8JKgYDwncX5GGhMwXpJ7HBaT0vD3vASSl1Ic3xl5+CGQaCO/RL6EVlrzcv/jt
         pBp2tXGjlaL/PbVdiRZGUkn1qFZGkSYWAXnrvia+CGOErbH0f1cNEdJAM/kNAISSp7xe
         0HvPZkfJAXzY4++rp/mZogGPHAfo4ac1Ekw2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=NE+VcgteX9DPqIbddc5At31Mop8Zi6oW/gojaJjb+00MpmCiDNBs+vdH7cVUTDpZVR
         90XEmlsgMD9ECGSTnud5IePPsjW+Soy5S+bzshg4lIL40R1YELA/IMj80zZNLoom0FDu
         jc/reRhwJ2ipcNXu7EvpMR0/hCfFfrD+i8lug=
Received: by 10.204.16.88 with SMTP id n24mr7503718bka.52.1253113827959;
        Wed, 16 Sep 2009 08:10:27 -0700 (PDT)
Received: from ?192.168.2.100? (port-92-195-101-71.dynamic.qsc.de [92.195.101.71])
        by mx.google.com with ESMTPS id f31sm3229806fkf.38.2009.09.16.08.10.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Sep 2009 08:10:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
In-Reply-To: <m3vdjj2ceq.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128658>

> I don't know whether --first-parent or --simplify-by-decoration, or
> perhaps --dense is what you want (you can also use --graph for better
> visualization).

Thank you. I think

git log --topo-order --dense --merges firstmerge..HEAD

comes very near. I still have to use "git log --topo-order", find the 
commit of interest, and search upwards for the next merge that is used
as firstmerge above.
Unfortunately there are many merges in the net branch but it basically 
does the job.

An example:

1. git log --topo-order, search for "Wakeup fixes" gives commit edd7fc.
2. Search backward for "^Merge" gives commit a8519d.
3. git log --topo-order --dense --merges edd7fc.., search for a8519d.
4. A search backwards for Linus gives you the merge into mainline: d7e966.

This commit is basically what I wanted to know. Even nicer would be a 
three-commit-line only consisting of the merge into wireless, the merge 
into net and the merge into mainline.

> Or use git-show-branch... :-)

I don't think I can use that since I have only a master branch sitting 
around.
