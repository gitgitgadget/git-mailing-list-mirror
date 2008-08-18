From: Thomas Harning <harningt@gmail.com>
Subject: Re: Best method of detecting if list of commit refs is a parent
Date: Mon, 18 Aug 2008 09:37:25 -0400
Message-ID: <17B524E9-FDF9-4585-AFBD-A5304E3A4AA6@gmail.com>
References: <e47324780808171924j237688faj9e13740f89e75fdf@mail.gmail.com> <7vfxp3ndec.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 15:38:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV4wN-0007KH-6J
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 15:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbYHRNhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 09:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbYHRNhb
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 09:37:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:45955 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbYHRNhb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 09:37:31 -0400
Received: by ug-out-1314.google.com with SMTP id c2so195732ugf.37
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 06:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=n5d6C448uQQJ/yMaT+8Zu4WCoWhsu3uTZdhVPreDNEA=;
        b=tGNwCm8uXQngdjLfI9/1Er6fAOE9X6kKr91y9hE25NyxqXWe1sXTia2OkrctizAxBS
         fIlsVLGobGJjwOmYKAGMSR846GKd7g9D8pgQNs8IiL92iPtFjEpiHp5O4JuS+oMEuB0o
         auYC7GBJ8qbQaJj+ITGeVvuECtB1j30n0IQVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=eloZMlA2qwSJOIgxCEFiz/YbaagRCCQyiSSCuNd2Jhfab66SADW1CbEdEjF2J7/zp3
         ojX1AqeqyT7ZhHtM80eQo8Tn/cFNcvZYciUcZC1EHUInxeLIvmGXmb/z5T1TFKm9oLm8
         xprBb4Qf4Haw+IC7+V85INEvAPI+fGXggcY/Y=
Received: by 10.67.88.7 with SMTP id q7mr3774766ugl.18.1219066649474;
        Mon, 18 Aug 2008 06:37:29 -0700 (PDT)
Received: from ?10.1.10.196? ( [75.149.208.122])
        by mx.google.com with ESMTPS id h1sm1421396ugf.22.2008.08.18.06.37.27
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Aug 2008 06:37:28 -0700 (PDT)
In-Reply-To: <7vfxp3ndec.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92706>

On Aug 18, 2008, at 12:41 AM, Junio C Hamano wrote:
>
> If you have bunch of commits A B C D E F and if you would want to know
> which one of them is reachable from X, you could of course run merge- 
> base
> once for each of A..F.  Another way to do this would be to run:
>
> 	git rev-list A B C D E F ^X
>
> and look at the output.  The ones among A..F that appear in the  
> output are
> not reachable from X.  The ones that are reachable from X do not  
> appear in
> the output.
>
> This is because "rev-list" outputs everything reachable from the given
> commits without ^ prefix, excluding the ones that are reacahble from  
> the
> ones prefixed with ^.
Perfect!  Now... is there built-in way to invert this to list those  
that 'are' reachable..... Or would the inverse really end up  
calculating the difference between input list and output list?
