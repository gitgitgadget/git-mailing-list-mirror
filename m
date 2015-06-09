From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: On undoing a forced push
Date: Tue, 09 Jun 2015 19:36:20 +0530
Message-ID: <5576F2DC.7040603@gmail.com>
References: <20150609121221.GA14126@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 16:06:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2KAg-0003I0-JU
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 16:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328AbbFIOG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 10:06:27 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34457 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbbFIOGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 10:06:25 -0400
Received: by pdbki1 with SMTP id ki1so15988916pdb.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=qEyuV9R11RYp/RXZ1JMRbdlVM+PKvtWRlJG2nRVuSTc=;
        b=tX0AKjz/o6Rhk5QldwnRPH6mf2m/tSwkOspZgr+wJJma3TdB1YNynr805H+shLxuFl
         LRlsKyC0qOBdfefQqTJY5RGdQRRKof+lUqCAgoqO4/1fXiPYkAAIbMZM2CQ21gBd+IRN
         /DPjYZz70VJ4nVfSn2xJk0dovgbiUcuIe0dIUeUvMt8OZJ9OQNw8jN4+9Dfw5Io55l1i
         zndZb0NvePQr4NLu84FHaxR/30Iq3VWicInPmqxb7UpVvtwze/JCeDVPkJVUWP4/5cL8
         CNtY7KpwkgNB7JjRFt/trNaR9WB5BDMxw/XMjICMSCC6C9htP6NXmYOvXLU6glbrszI3
         qkmg==
X-Received: by 10.68.176.131 with SMTP id ci3mr39941552pbc.146.1433858785152;
        Tue, 09 Jun 2015 07:06:25 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.195.191.155])
        by mx.google.com with ESMTPSA id l1sm5795583pdp.71.2015.06.09.07.06.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 07:06:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150609121221.GA14126@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271180>

On 06/09/2015 05:42 PM, Duy Nguyen wrote:
> From a thread on Hacker News. It seems that if a user does not have
> access to the remote's reflog and accidentally forces a push to a ref,
> how does he recover it? In order to force push again to revert it
> back, he would need to know the remote's old SHA-1. Local reflog does
> not help because remote refs are not updated during a push.
> 
> This patch prints the latest SHA-1 before the forced push in full. He
> then can do
> 
>     git push <remote> +<old-sha1>:<ref>
> 
> He does not even need to have the objects that <old-sha1> refers
> to. We could simply push an empty pack and the the remote will happily
> accept the force, assuming garbage collection has not happened. But
> that's another and a little more complex patch.

If I am not mistaken, we actively prevent people from downloading an
unreferenced SHA (such as would happen if you overwrote refs that
contained sensitive information like passwords).

Wouldn't allowing the kind of push you just described, require negating
that protection?
