From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git-status segmentation fault in master / OS X
Date: Wed, 20 Jan 2010 19:58:54 +0700
Message-ID: <fcaeb9bf1001200458v436a8adeq5cfc6753900e6c0c@mail.gmail.com>
References: <57518fd11001190959n355a0f22p7caa7251b705efaf@mail.gmail.com>
	 <20100120004146.GB16824@coredump.intra.peff.net>
	 <7vd4157fwt.fsf@alter.siamese.dyndns.org>
	 <57518fd11001200243v416aa5f9o37a3b5b92bef3b57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 13:59:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXa9M-0003mM-K1
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 13:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806Ab0ATM64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 07:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925Ab0ATM64
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 07:58:56 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:52721 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab0ATM6z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 07:58:55 -0500
Received: by pwj9 with SMTP id 9so3130918pwj.21
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 04:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=kpn7zkghA5LDvEhcXqMwiT2r5/TLcL4KDPadzKExR0w=;
        b=Fbw/lToxsRHWbZnqSq25LVvJZ0JqT7IgGGYi5tcus+Lh9+JWYtbdVy3pgUKPLx6UbF
         P5YGLa8LGHMfegvL9hZpW0LTXKIourx8u9j+vwiKRIKbhZalFy/IaNYYy+iPMguBSman
         NXulxvVQlSrQN7r2tJXaOu2ZMPlScpxMTjoUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=JzwVvQNbcw2ouM0CKxLwtQjdREPCilPaDhm+bT4pghMFUTNcPN+hd3GukjDrJaNrTj
         mWzE3++pf/IzF2Xu0XSUMmDdfV3J5y8gXQkeARSxEGvQP/Y+rs35zttBINqpr5tA9glF
         ZehB/k/3Fa3Lq92H0aqYB0zcAv2MCp8I6K+q4=
Received: by 10.114.45.13 with SMTP id s13mr6168559was.167.1263992334897; Wed, 
	20 Jan 2010 04:58:54 -0800 (PST)
In-Reply-To: <57518fd11001200243v416aa5f9o37a3b5b92bef3b57@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137548>

On 1/20/10, Jonathan del Strother <maillist@steelskies.com> wrote:
>  One thing I wondered about from that commit - shouldn't the "buf =
>  xmalloc(size);" on dir.c:252 be "buf = xmalloc(size+1);" ?  I haven't
>  really looked at the program flow there, so may be wrong...

You would also need to revert 66c3fa0 (Avoid writing to buffer in
add_excludes_from_file_1() - 2009-08-20) and see if it fixes the
problem. I think there is a potential memory corruption at "buf[i - (i
&& buf[i-1] == '\r')] = 0;". Don't know if it is the cause though.
-- 
Duy
