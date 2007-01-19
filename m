From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git ls-files -o under .git/ prints all repository files
Date: Fri, 19 Jan 2007 09:02:50 +0100
Message-ID: <81b0412b0701190002i1552a16bq5ba7cbebcaa729df@mail.gmail.com>
References: <87r6trsu7n.wl@mail2.atmark-techno.com>
	 <7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Yasushi SHOJI" <yashi@atmark-techno.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 09:03:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7oiC-0004cm-M9
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 09:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbXASIC5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 03:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbXASIC5
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 03:02:57 -0500
Received: from hu-out-0506.google.com ([72.14.214.235]:51629 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964925AbXASIC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 03:02:56 -0500
Received: by hu-out-0506.google.com with SMTP id 36so385909hui
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 00:02:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QzpbZuJhHcpKKsht89oRYRQza+lOcOe8UQXIwsBn5/yeVZJMg2Q6XCKcXBMq+wqG5CbnEJAwZeu9QH8n8SFSpZDTD4OMW2x3+u8Bzkk2yR7hIBRdjqswAeUt9lsx5JKrEswAiTnm22COh0KtghobTxwV84kjiPE4wx+wzslfUfU=
Received: by 10.78.50.5 with SMTP id x5mr1742964hux.1169193772091;
        Fri, 19 Jan 2007 00:02:52 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Fri, 19 Jan 2007 00:02:50 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37160>

On 1/19/07, Junio C Hamano <junkio@cox.net> wrote:
>  static void safe_create_dir(const char *dir, int share)
>  {
> -       if (mkdir(dir, 0777) < 0) {
> +       mode_t mode;
> +
> +       mode = share ? 0777 : 0333;
> +       if (mkdir(dir, mode) < 0) {

Does not work for existing directories, does not work
on FAT and alike at all.
