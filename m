From: David Aguilar <davvid@gmail.com>
Subject: Re: A question about using 'add -p' to split the patch
Date: Sun, 14 Jun 2009 23:12:12 -0700
Message-ID: <20090615061211.GA53136@gmail.com>
References: <46dff0320906142008v4f278d3ek3eebfa36f7fcf06a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 08:12:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG5Qy-0001ja-14
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 08:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbZFOGMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 02:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbZFOGMS
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 02:12:18 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:56719 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbZFOGMS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 02:12:18 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1394186wfd.4
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 23:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mwUE4Q72nnYfuAAZOEdwIW1Tbv98PO+EBrleZkmmPUk=;
        b=oxxn5RD9W2QpK4G8gReewjJy2fIXOz8A5kKU7iMXBi14NFd/dDQ//2KAgLDQlE6x8h
         zUioULMLU0z6k+6LrO3fGYtNaZP3xc/ZUsjItEvrHOAQlpBUOueVxhZner9H4tBQv0kb
         5aVbUttvH7DD4ZZxki4uGMj0jQ8p5VeCuCYwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=crEOwxCuyEEinCKrsxeUtyuo83nW6a6+3qEj9uLC/EDrbY033CnQngJTQDWswTR2os
         AWR1bK8MD8sssTtKU7vjqPS+ygwQT+5qxuMPNE6Bbo8NnSKvnXAGuon0/DnFPLly/3bz
         hWxuNw1Ia2+P+LK2E+1IF/Tshr/DKqALu5RBI=
Received: by 10.142.166.7 with SMTP id o7mr2765283wfe.239.1245046340722;
        Sun, 14 Jun 2009 23:12:20 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 20sm14967wfi.20.2009.06.14.23.12.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Jun 2009 23:12:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <46dff0320906142008v4f278d3ek3eebfa36f7fcf06a@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121583>

On Mon, Jun 15, 2009 at 11:08:51AM +0800, Ping Yin wrote:
> file bt.php in the HEAD:
> 
> function bt_add($path) {
>  return;
> }
> 
> file bt.php in the working directory:
> 
> function bt_move($path, $pos) {
>   return;
> }
> function bt_add($path, $pos) {
>   bt_move($path, $pos)
>   return;
> }
> 
> Now i want to split the change into two parts:
> First introduce bt_move
> Then add a param pos to bt_add and call bt_move
> 
> With the 'e' action of 'add -p', i got
> 
> -function bt_add($path) {
> +function bt_move($path, $pos) {
> +  return;
> +}
> +function bt_add($path, $pos) {
> +  bt_move($path, $pos)
>    return;
>  }
> 
> Then, i want to edit the patch to get
> 
> 
> function bt_move($path, $pos) {
>   return;
> }
> function bt_add($path) {
>   return;
> }
> 
> However, whatever i do, the patch fails to apply. Any suggestion?

Use git-gui or git-cola to select just bt_move() for addition.
You can stage specific lines.

After doing that it's often a good idea to git stash --keep-index
so you can test it before committing.

enjoy,

-- 
		David
