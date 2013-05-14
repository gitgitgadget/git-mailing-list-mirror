From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH v3 10/10] remote-hg: trivial reorganization
Date: Tue, 14 May 2013 15:27:51 -0500
Message-ID: <51929e47f4e8_13a8f89e1823ba@nysa.mail>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
 <1368486720-2716-11-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 22:29:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcLr1-00035B-0G
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 22:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758348Ab3ENU3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 16:29:43 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:48000 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757626Ab3ENU3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 16:29:42 -0400
Received: by mail-ob0-f170.google.com with SMTP id er7so1128053obc.29
        for <git@vger.kernel.org>; Tue, 14 May 2013 13:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:message-id:in-reply-to:references
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=t3BSvdsjvai02fKO7/bQ54w1AY+qlhf/cTgoC4ryv4A=;
        b=YjF83AUfqv64byZ+0dpx9Q05pKs/NURQAHUKqcnJZZ3eHaf+cQDbc4YatlTk/Q8D7F
         zHd+sHvK11pjJ6l9Ppm6NlKJ68cfVoaXI4qKtBE8oCxuYEsfoOTjGd/WwgE5juKEwOAl
         4X+bYZkOCDJ2VCaXyyVdteXn3yUIS94tumopla6QjLaxU6l6Vex/gIzgEicowMmD8tRn
         UGBlHU1Q14wkz1ahLn7rNRH6MSnvCTQeCa3+EL1VOGxXu15ZuxDxMSYjagL3Ub7rRQfE
         gTOYFXHd04gcwDukoXuAK9IS1z7BHM/vnSPlo19jSCYvEZhoETF0Sr5En5h9TQev6xkO
         NnZA==
X-Received: by 10.60.141.226 with SMTP id rr2mr17361474oeb.35.1368563381975;
        Tue, 14 May 2013 13:29:41 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id qj8sm23776041oeb.2.2013.05.14.13.29.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 May 2013 13:29:40 -0700 (PDT)
In-Reply-To: <1368486720-2716-11-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224342>

Another no-brainer; simply shuffling some code.

Felipe Contreras wrote:
> We only need to get the remote dict once.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-hg | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index dc276af..96bed8d 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -860,6 +860,7 @@ def do_export(parser):
>  
>      if peer:
>          parser.repo.push(peer, force=force_push, newbranch=True)
> +        remote_bmarks = peer.listkeys('bookmarks')
>  
>      # handle bookmarks
>      for bmark, node in p_bmarks:
> @@ -886,8 +887,7 @@ def do_export(parser):
>              continue
>  
>          if peer:
> -            rb = peer.listkeys('bookmarks')
> -            old = rb.get(bmark, '')
> +            old = remote_bmarks.get(bmark, '')
>              if not peer.pushkey('bookmarks', bmark, old, new):
>                  print "error %s" % ref
>                  continue
> -- 
> 1.8.3.rc1.579.g184e698

-- 
Felipe Contreras
