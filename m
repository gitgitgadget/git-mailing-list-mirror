From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] templates/Makefile: work around SGI install which assumes
 / if ROOT not defined
Date: Mon, 18 Aug 2008 19:52:50 -0500
Message-ID: <FnxO7Orp3rSZw-HOO0O0Mr3CM46BkVX3CwFWT098m6GBmWq0jNk82A@cipher.nrlssc.navy.mil>
References: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil> <XAO6w2f4AxtqGEL6HNTkRYjhSFFUavQK8LYfdASEGw3-LRoH4_7Cdg@cipher.nrlssc.navy.mil> <7vhc9hlwt3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Gerrit Pape <pape@smarden.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 02:55:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVFV7-0005Vi-11
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 02:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757827AbYHSAxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 20:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758312AbYHSAxt
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 20:53:49 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46793 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757837AbYHSAxs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 20:53:48 -0400
Received: by mail.nrlssc.navy.mil id m7J0qpA8004080; Mon, 18 Aug 2008 19:52:51 -0500
In-Reply-To: <7vhc9hlwt3.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 19 Aug 2008 00:52:50.0989 (UTC) FILETIME=[E7F185D0:01C90195]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92799>

Junio C Hamano wrote:
> I do not see absolutely any reason to use install there.
> 
> I have to wonder why 9907721 (templates/Makefile: don't depend on local
> umask setting, 2008-02-28) did not do this instead:
> 
> 	$(QUIET)umask 022 && ls *--* 2>/dev/null | \
> 	while read boilerplate; \
> 	do \
> 		case "$$boilerplate" in *~) continue ;; esac && \
> 		dst=`echo "$$boilerplate" | sed -e 's|^this|.|;s|--|/|g'` && \
> 		dir=`expr "$$dst" : '\(.*\)/'` && \
> 		mkdir -p blt/$$dir && \
> 		case "$$boilerplate" in \
> 		*--) ;; \
> 		*) cp $$boilerplate blt/$$dst ;; \
> 		esac || exit; \
> 	done && \
> 	date >$@
> 

That works just fine for me.

-brandon
