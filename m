From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v3 5/6] fn_out_diff_words_aux: Handle common diff line more carefully
Date: Mon, 5 May 2008 00:53:17 +0800
Message-ID: <46dff0320805040953i4230a686j8e8d63eaa6728c2f@mail.gmail.com>
References: <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-1-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-2-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-3-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-4-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-5-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-6-git-send-email-pkufranky@gmail.com>
	 <alpine.DEB.1.00.0805041053380.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 04 18:54:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JshTS-00051y-E5
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 18:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbYEDQxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 12:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbYEDQxS
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 12:53:18 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:19011 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbYEDQxS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 12:53:18 -0400
Received: by an-out-0708.google.com with SMTP id d40so472101and.103
        for <git@vger.kernel.org>; Sun, 04 May 2008 09:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5dqklfwldtE6h+ZdfuHXGXr5QheRgijZA+HMN8J9u+0=;
        b=co73z/2iqug0xXt5B7+n7Rv/hPloeB1yQmEqVgxTP5+fa2AjGzHubFwvz1IpMzxd9JRfrMNb9rJMOCbfkR7q2anmkoutqCUBaKjkh0WLaGZ8k1qJ7WzyMxD7eFLN45gC7X40U739HOFCloYLgD62IDx14NgivNpAprgobhShVIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ckZVPxgdDqjBytNx+fykZs5iutZ0mS9rgy52KVvipyxnu89eTK7AovrpDPLAYigaNoUShwycOfdW5ggZ4eAfHeVWruF+k8Zhuh0gV5p0Gq8MeAsE+kiaifzUD6CqEEGA3Jn2JuzSnrQZ6L/4PhjnubCZMAo4t2Banr4+rgOYmyU=
Received: by 10.100.33.4 with SMTP id g4mr6718481ang.111.1209919997063;
        Sun, 04 May 2008 09:53:17 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sun, 4 May 2008 09:53:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805041053380.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81188>

On Sun, May 4, 2008 at 5:54 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  On Sun, 4 May 2008, Ping Yin wrote:
>
>  > Before feeding minus and plus lines into xdi_diff, we replace non word
>  > characters with '\n'. So we need recover the replaced character (always
>  > the last character) in the callback fn_out_diff_words_aux.
>  >
>  > Therefore, a common diff line beginning with ' ' is not always a real
>  > common line.
>
>  Umm, why?

Because we need recover the replaced character.

Say, for a common diff line " foo", after restoring the replaced
character, the corresponding line in minus and plus may be different.
For example, "foo(" and "foo)".

>  > And we should check the last characters of the common diff line. If they
>  > are different, we should output the first len-1 characters as the common
>  > part and then the last characters in minus and plus separately.
>
>  Umm, why?

Explained.



-- 
Ping Yin
