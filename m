From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 08/11] streaming_write_entry(): support files with holes
Date: Mon, 16 May 2011 17:53:39 +0700
Message-ID: <BANLkTi=VKb44yYuXdKLxrvFCVkfsDZSb4Q@mail.gmail.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com> <1305505831-31587-9-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 12:54:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLvRJ-0003VI-4e
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 12:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742Ab1EPKyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 06:54:11 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56142 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592Ab1EPKyK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 06:54:10 -0400
Received: by bwz15 with SMTP id 15so3607682bwz.19
        for <git@vger.kernel.org>; Mon, 16 May 2011 03:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=jAf+pLNA01yGY9+DeJjBa16ny2Am7fhhUrMSRDVgGls=;
        b=sqWsOfHt7d6czW75xxKxEBI7+XB/1BG0rgG9bLKjro0NUveGNCLCA5UmUTl/kgYf1V
         ypNrIDye3dkKWiXy1iF9bumhyTGGsMTpabpp+zKWY7y5TByqMbu5smByIZ3Gs1dJcre3
         6XXHH/zuUClInlRqjP3um6FgY97Wsec1IXXQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=TyQqG3azGn1tYTvycWYy/cHuZjrMvmvTC90kW6Xk4P/LijzUEA/lC39db0vqqLdf7t
         jG1m36lV8er1hiQhBN56SVDORZYw5Y9KAgfFmVC6UJHcQgE8wiU9H/fo36WPNwREamw2
         FgKQ/pg0kYTL7n7D+tBoA4CQzfKfkdcCwLrLA=
Received: by 10.204.19.3 with SMTP id y3mr3905470bka.180.1305543249137; Mon,
 16 May 2011 03:54:09 -0700 (PDT)
Received: by 10.204.46.71 with HTTP; Mon, 16 May 2011 03:53:39 -0700 (PDT)
In-Reply-To: <1305505831-31587-9-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173725>

On Mon, May 16, 2011 at 7:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> One typical use of a large binary file is to hold a sparse on-disk hash
> table with a lot of holes. Help preserving the holes with lseek().

Should that be done only with big enough holes? Random zeros may
increase the number of syscalls unnecessarily.
-- 
Duy
