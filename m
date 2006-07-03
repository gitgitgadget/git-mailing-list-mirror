From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] Make git-fmt-merge-msg a builtin
Date: Mon, 3 Jul 2006 18:26:21 +0300
Message-ID: <20060703182621.dbed5b5f.tihirvon@gmail.com>
References: <Pine.LNX.4.63.0607031530380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060703171751.2ed33220.tihirvon@gmail.com>
	<Pine.LNX.4.63.0607031632290.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Jul 03 17:26:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxQJe-0001vQ-9E
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 17:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWGCP0W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 11:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWGCP0W
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 11:26:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:64363 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751196AbWGCP0V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 11:26:21 -0400
Received: by nf-out-0910.google.com with SMTP id k26so446533nfc
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 08:26:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=K/1QN474CAXuvW1K8Ipp1V/IJUyKqUVUJ+TOldN6lmuiYB8WkpdolWtOnvhR0/+nfstQwiDGNAqzyqeurbDWGOzowLa9FWm5A4ZBcu/ef6PRKUM1KQ37MYXN+r+v1C6SQdCcH1uir13ch6HhqkKeGfTf1M+b3C8IWJoblSQ9M00=
Received: by 10.48.161.1 with SMTP id j1mr2513428nfe;
        Mon, 03 Jul 2006 08:26:19 -0700 (PDT)
Received: from garlic.home.net ( [82.128.203.109])
        by mx.gmail.com with ESMTP id r34sm4660064nfc.2006.07.03.08.26.18;
        Mon, 03 Jul 2006 08:26:18 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607031632290.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.19; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23184>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> I had in mind that I want to use path-list instead (which is cooking in 
> the merge-recursive efforts ATM). And there, I would add a flag 
> needs_payload. Opinions?

This code is so simple that making the path_list more complex
(needs_payload special case?) is not worth it.  I have not looked at the
code very closely though and have no idea what I'm talking about :)

> > > +static void free_list(struct list *list)
> > > +{
> > > +	int i;
> > > +
> > > +	if (list->alloc == 0)
> > > +		return;
> > 
> > Unnecessary if nr is 0 too.
> 
> No. If nr == 0, alloc need not be 0, and if it is not, list and payload 
> are still allocated.

If alloc is 0 then nr is 0 too (at least it _should_ be).  The code would
effectively become:

	for (i = 0; i < 0; i++) {
		...
	}
	free(NULL);
	free(NULL);
	list->nr = list->alloc = 0;

But this is not important...

> > free(NULL) is safe.
> 
> Is it? I vaguely remember that I had problems with this on some obscure 
> platform.

I don't think so.

-- 
http://onion.dynserv.net/~timo/
