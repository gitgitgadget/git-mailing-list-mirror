From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] Added --export option to git-send-email.
Date: Sun, 13 Jul 2008 19:42:35 -0400
Message-ID: <32541b130807131642k1382cf84gdf5e8bb8d2ff4ffe@mail.gmail.com>
References: <20080710170735.4c5b237a@linux360.ro>
	 <7vskudr11m.fsf@gitster.siamese.dyndns.org>
	 <32541b130807131432j78e5100dyea20893268321466@mail.gmail.com>
	 <7vbq11qxfb.fsf@gitster.siamese.dyndns.org>
	 <32541b130807131444s5e9ea0d6v9610dd5871467fc9@mail.gmail.com>
	 <7vvdz9o2wu.fsf@gitster.siamese.dyndns.org>
	 <32541b130807131521w79cbf23m5934678e68312798@mail.gmail.com>
	 <7vlk05o14i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eduard - Gabriel Munteanu" <eduard.munteanu@linux360.ro>,
	ryan@michonline.com, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 01:43:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIBE9-0008Sl-CO
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 01:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754328AbYGMXmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 19:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754290AbYGMXmh
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 19:42:37 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:2477 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498AbYGMXmg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 19:42:36 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2289779ywe.1
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 16:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=AGGmaXRPAuIXHGdcAsQRQoiQbaLGTKmNiR+PVByJlnE=;
        b=pqluR6GuYFO0g3P9hjlaKJ8N+HCYxkI2By0w+wKbsiW0uPihHs67y3gGwl6rP7+etW
         GHWeGq8d1pBcsgtm5ILqcz8zls+gST2eIZw7CCIhFoLPQyNQVhzSbzPzDbcY2YvGNDXW
         9tmqjUJzp0UEEcFVIoCtTgwB6I4mzaEM0u6co=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZHdKeOmkHftXwaEKRiYIk8BmHNiz8u3/u7YlHh2U6GMUCV79uGOinHTybnjuIjEaW1
         tf8iKaH563Ve3Z5EaCb0hJwe0WfiRUZR+Y/JNhSe5AJ3kE3NnPb0O294FV2t9JTeghMr
         V6+9E+2bmTKSwItl5MHFHXG72PBQpzqb6dFBU=
Received: by 10.150.52.2 with SMTP id z2mr19334523ybz.43.1215992555441;
        Sun, 13 Jul 2008 16:42:35 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Sun, 13 Jul 2008 16:42:35 -0700 (PDT)
In-Reply-To: <7vlk05o14i.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88358>

On 7/13/08, Junio C Hamano <gitster@pobox.com> wrote:
>  If this additional option claims to produce a mbox, I think:
>
>   (1) quoting only /^From / (not /^>*From/) to be consistent with the
>      standard practice is the right thing to do; and
>
>   (2) reading side might need to also pay attention to /^>From /, in case
>      somebody feeds an output from this option back to send-email.
>
>  However, strictly speaking,(2) may break the standard workflow of
>  generating patches with format-patch and feeding the result to send-email,
>  as format-patch does not do /^From / munging (and it shouldn't).

Note that it's generally very bad practice to do (2) unless you always
quote /^>*From/.  Quoting only /^From/ and *then* trying to dequote it
correctly actually increases the number of places where you can
corrupt a message.  As a sign that very few programs do (2), I think
it's pretty clear that a lot more people see "From" rewritten as
">From" in their mail app of choice than the reverse.

There is also some debate about what "standard practice" means.  See:
http://homepages.tesco.net/J.deBoynePollard/FGA/mail-mbox-formats.html
.

If git is going to start actually producing mbox files (as opposed to
just individual messages as it does now), it should probably
explicitly take a stance on the issue... or perhaps make it
configurable.

Have fun,

Avery
