From: Thomas Harning <harningt@gmail.com>
Subject: Re: git svn segfaults in _Delta.so
Date: Wed, 10 Sep 2008 14:40:31 -0400
Message-ID: <9B7A97D1-7175-4FCC-94CB-21EBE12E4F88@gmail.com>
References: <E7387B42-6A3D-432B-8478-71A5E510D905@gmail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Harning <harningt@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 20:42:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdUdx-0007kZ-6B
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 20:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbYIJSkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 14:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbYIJSkt
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 14:40:49 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:49731 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbYIJSks (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 14:40:48 -0400
Received: by gxk9 with SMTP id 9so14483326gxk.13
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=qWO/Gci2EyXXLJgaFCci6Vh9iEp4obsWzuxNM47L8ZY=;
        b=DPNf4dcankMTskd6z8SBhwGDlTbfbkFHSsd7V8nx6QxKt5j1XGM6CQ2RyI8ZH/szSn
         OnrB3veRCDIfq09bpItQ8RvzWJ1t8/5JUZCcyKWjQSGdrn3DDUBOdAP4HCZl3gx8Pd6E
         Y7VU9yxG78/NDzkW/qvVtl/aycbNY4hJkQf0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=HhCrkAMxhlgeeUXVvg4+ASTztIU8/xxFs98/nXesVr30FLcmvW+PuK+MOvI5HSEEkJ
         f7ACthXUqrnh/shwVatfS5sSiLQJWNruT/e4fd1WSKmuMSUZjRpBEHLmWQctILOMFD/6
         KtfJE5+zIe/l0/H/FdDhWJNoDWtqHWlS1rT6A=
Received: by 10.67.28.14 with SMTP id f14mr5379589ugj.2.1221072045306;
        Wed, 10 Sep 2008 11:40:45 -0700 (PDT)
Received: from ?10.1.10.196? ( [75.149.208.122])
        by mx.google.com with ESMTPS id b39sm16556228ugf.41.2008.09.10.11.40.41
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 10 Sep 2008 11:40:44 -0700 (PDT)
In-Reply-To: <E7387B42-6A3D-432B-8478-71A5E510D905@gmail.com>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95545>

On Sep 10, 2008, at 2:21 PM, Thomas Harning wrote:

> I just recently setup a new system and installed subversion 1.5.1  
> and the latest git from head.
>
> On an existing repository (copied from the same system but slightly  
> older software) running git svn rebase will cause it to segfault in  
> _Delta.so (part of subversion's perl libraries).... even when there  
> is nothing to do... it even seems to successfully do all the  
> operations.  I've built subversion and git with debugging enabled  
> and cannot get any useful stack-trace. the stacktrace is:
>
> #0  0x00007fbed7edd3a0 in ?? ()
> #1  0x00007fbed99fa75d in ?? ()
> #2  0x0000000000000001 in ?? ()
> #3  0x00007fbed99fb217 in ?? ()
> #4  0x00007fbed99e82d8 in ?? ()
> #5  0x0000000000000001 in ?? ()
> #6  0x000000000070e250 in cwd.17580 ()
> #7  0x000000000070d7f8 in buffer.17586 ()
> #8  0x0000000000f7f408 in ?? ()
> #9  0x00007fbed99fb205 in ?? ()
> #10 0x0000000000000000 in ?? ()
>
>
> The only way I know that it is _Delta.so is that in 'dmesg' i get:
> git-svn[1277]: segfault at 7f64fa7213a0 ip 7f64fa7213a0 sp  
> 7fff07a9a2b8 error 14 in _Delta.so[7f64fa92c000+22000]
>
> In another machine w/ very similar software (slightly older by a  
> month or so) I do not see these segfaults.  However it is running  
> svn 1.4.6  .. so it might be svn versions...  will report on status  
> after downgrade
svn 1.4.6 does not suffer the segfaults...
