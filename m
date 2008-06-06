From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] git-blame: refactor code to emit "porcelain format" output
Date: Fri, 6 Jun 2008 11:22:07 +0200
Message-ID: <200806061122.09621.jnareb@gmail.com>
References: <940824.46903.qm@web31808.mail.mud.yahoo.com> <7vd4mw4dpp.fsf@gitster.siamese.dyndns.org> <7v8wxk4dml.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 11:23:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4YAo-00057p-16
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 11:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbYFFJWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 05:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbYFFJWm
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 05:22:42 -0400
Received: from gv-out-0910.google.com ([216.239.58.185]:50638 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbYFFJWl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 05:22:41 -0400
Received: by gv-out-0910.google.com with SMTP id e6so338401gvc.37
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 02:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=wCqrWigqix8BFWv6NpNInHWkqRXWx7MX/p13XwI1sqY=;
        b=cpMF3vQ047yVdG7UdXC7EzhZeIJkOkjlX8RH4MVLqZZtjo66dcGKgg4wxMgElxam21
         4GEXfMDsOs9wYPiNBKT/9gkbXOakCfeRduO1EkammSC4+vwfaAG+Gi/yWsLqcldfvssq
         mFYwqiVjVPMlzn6tJaMzfWo3BNjudD6AwCRmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=hK+TuNOI6iyVKtObKy5dgdcmjviK1Fk9AlfHY1yEuxuXd3nO8xtqQhz80heEJd5RU5
         RX1z1OGBCRgyB2X5WPqMxqajYv9Ls5ZdapO0uGUCvJzt/d/l8fqb4ZJ1v0Q88AonQqWq
         HJyZfjmkmNhDBlVCFu/vTGYipcrqyIf4Yf8IM=
Received: by 10.103.186.7 with SMTP id n7mr1408665mup.17.1212744159384;
        Fri, 06 Jun 2008 02:22:39 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.247.141])
        by mx.google.com with ESMTPS id y37sm6775122mug.9.2008.06.06.02.22.18
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Jun 2008 02:22:37 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v8wxk4dml.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84043>

On Tue, 5 Jun 2008, Junio C Hamano wrote:

> Both the --porcelain and --incremental format shared the same output
> format but implemented with two identical codepaths.  This merges them
> into one shared function.

They have _almost_ the same, but not _exactly_ the same output:

  INCREMENTAL OUTPUT
  ------------------

  [...]

  The output format is similar to the Porcelain format, but it
  does not contain the actual lines from the file that is being
  annotated.

  [...]

  . Unlike Porcelain format, the filename information is always
    given and terminates the entry:

        "filename" <whitespace-quoted-filename-goes-here>

     and thus it's really quite easy to parse for some line- and
     word-oriented parser (which should be quite natural for most
     scripting languages).

But I guess this got addresssed in the patch, doesn't it?
-- 
Jakub Narebski
Poland
