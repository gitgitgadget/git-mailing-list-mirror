From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 13/13] Build in merge
Date: Mon, 30 Jun 2008 19:41:07 +0200
Message-ID: <81b0412b0806301041w70431da0u775d56920bf4a521@mail.gmail.com>
References: <20080630013612.GY2058@genesis.frugalware.org>
	 <e8d1385cc49a06ca3fae28231ebc66a333ce4ffb.1214789764.git.vmiklos@frugalware.org>
	 <7vd4lz4gtw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Olivier Marin" <dkr@freesurf.fr>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 19:42:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDNOE-0003NP-1f
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 19:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043AbYF3RlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 13:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759146AbYF3RlN
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 13:41:13 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:33341 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762585AbYF3RlM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 13:41:12 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1496883fkq.5
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 10:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=b01CJqwa1r1J9mS8MhjHMuQnYbfE38DYfcO+bNua7ec=;
        b=mxCAV1rkjKwgZDTqMwdsaOCA/obwtyfi+g/Bx9sF3aqof09KCeKzbLp40CEiNtvR1k
         ywQdCMbPvMmedbrchZ4mkmOvA1WQUUfK/cEH4WEoa2RUTptkpKAmZVi+Q9dAc8rtvJEt
         a13lNfN31Hb7CRwQhWiYm58TlJvYFn+lxuEwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jUdWoxonqDYnDrdg/ngyeoLvLMmrUl3gvTmcfReYfLcNGfBQrGs6CWLbYqL1KfD6X0
         xed5pyR7zhmzmjFxZ2KCzxsNxJmJYjUVEqW0UtJRsOCRevhgYJqWwF0aWAl2o5c3DRjR
         ThDGbV+ULZy71UzTWe3Pi1UtjvEa1nRYsFdmg=
Received: by 10.78.97.7 with SMTP id u7mr1411536hub.28.1214847667892;
        Mon, 30 Jun 2008 10:41:07 -0700 (PDT)
Received: by 10.78.97.4 with HTTP; Mon, 30 Jun 2008 10:41:07 -0700 (PDT)
In-Reply-To: <7vd4lz4gtw.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86926>

2008/6/30 Junio C Hamano <gitster@pobox.com>:
> Miklos Vajna <vmiklos@frugalware.org> writes:
>> +     /* See if remote matches <name>~<number>, or <name>^ */
>> +     ptr = strrchr(remote, '^');
>> +     if (ptr && ptr[1] == '\0') {
>> +             len = strlen(remote);
>> +             while ((ptr = (char *)memrchr(remote, '^', len)))
>> +                     if (ptr && ptr[1] == '\0')
>> +                             len = ptr - remote - 1;
>> +                     else
>> +                             break;
>
> That's a funny way to say:
>
>        for (len = 0, ptr = remote + strlen(remote);
>             remote < ptr && ptr[-1] == '^';
>             ptr--)
>                len++;
>

Besides, Cygwin has no memrchr
