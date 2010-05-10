From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: Multiblobs
Date: Mon, 10 May 2010 15:58:10 +0200
Message-ID: <4BE810F2.3080107@gmail.com>
References: <loom.20100428T164432-954@post.gmane.org> <20100506062644.GB16151@coredump.intra.peff.net> <4BE3493B.8010409@gmail.com> <20100510063618.GD13340@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 10 15:59:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBTWL-0002da-LY
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 15:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620Ab0EJN6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 09:58:17 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:58847 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912Ab0EJN6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 09:58:16 -0400
Received: by bwz19 with SMTP id 19so1774055bwz.21
        for <git@vger.kernel.org>; Mon, 10 May 2010 06:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=tWepm2tqxhzXKm0OhV0urFdA+NOO5YX5TbDpRF2L8ng=;
        b=uPrpCn61QYlLlhlpW5v4t0k+8bPYbbiw7QYQj+bOqkOe8Hv2zoa50W110lhKs8MMlu
         JBnDQmeDb9ulxZ+LhK8NbEQpFpK86eucAxvJi0MpRFgqol82UhaC1+uMcfXaUN524lED
         fStqvl7rJCh7RmngEV66auSW3V9hKl1Xig6Us=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=UubRNwHeACiduf2aJAxB36ViFy+9HR+pDQ/D/1FgXfzFPa68wqCBIpCItcefPX09Ca
         cGIXG5kZK1woc/ei11Q6a9CAohtVNjFnejfbCUcW1o/d2ep6cEaF0XNUIjI7mWe2gabq
         dP72DkNtsl4oD4/dubvEGQDrPHdPHVxpD7EAk=
Received: by 10.204.7.194 with SMTP id e2mr21461bke.103.1273499892938;
        Mon, 10 May 2010 06:58:12 -0700 (PDT)
Received: from [10.143.20.33] (mars-fw.arces.unibo.it [137.204.143.2])
        by mx.google.com with ESMTPS id l1sm52351bkl.2.2010.05.10.06.58.11
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 06:58:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Lightning/1.0b1 Thunderbird/3.0.4
In-Reply-To: <20100510063618.GD13340@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146815>

On 10/05/2010 08:36, Jeff King wrote:
> Sure. And for those cases, I think clean/smudge filters are perhaps
> already doing the job.
>
>    
As a matter of fact, my idea was exactly to think of a multiblob as a 
git tree (maybe plus a signature).

With this, one can set up a "multiclean" filter, triggered by a filename 
pattern as for a normal filter or by the invocation of "file" to look at 
inner magic.

When this filter is invoked it should take the file to be cleaned as the 
stdin and output a tree at the output, while (as a side effect) 
populating the git storage by the normal blobs pointed to by the tree.

In a complementary fashion, the multismudge filter should receive the 
"multiblob" tree on stdin, and output on stdout the smudged file, 
inspecting the blobs pointed to by the tree to do the work.

This would require having trees as tree entries, and (I guess) also some 
update to the git package machinery, but apart from that should fit well 
with the current clean/smudge approach, nor significantly alter the git 
model.

Sergio
