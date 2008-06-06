From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] blame: show "previous" information in --porcelain/--incremental format
Date: Fri, 6 Jun 2008 11:27:59 +0200
Message-ID: <200806061128.04031.jnareb@gmail.com>
References: <940824.46903.qm@web31808.mail.mud.yahoo.com> <7vd4mw4dpp.fsf@gitster.siamese.dyndns.org> <7v4p884dlh.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 11:29:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4YG0-0006jX-N3
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 11:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbYFFJ2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 05:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbYFFJ2U
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 05:28:20 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:55353 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbYFFJ2T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 05:28:19 -0400
Received: by wx-out-0506.google.com with SMTP id h29so661683wxd.4
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 02:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=OGQVd4aLCtXC3oLrYQlVJhxHkjVfaAkFG/SCE5qEEwE=;
        b=H6caw00VVG7PspjxQZru+mRARQg+mYLRG9CJPMzs/WTsNF6PhfHp6Rwm/4koYK4q2Y
         dPIKvF3jFYM/B3/NLI4Z+0cd0YZwIzyi4HQXqqmY7HgtwmBAdXcAi4eBCpOKgzVr6hF9
         /nR4Y046f4cFLEYE73G+hTKgNHkC0MJiIQje4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=sSMGaiehoSdrZORMrwNtC1sISUokMMMKunYCKZZdUenCnl0hs9v4dq8gsBcfrTgF+D
         LO0KbqNz13xcj0+DIn++d6nwcupLzOIYUGAyYfciTWlYmfKLnW95IXp3nr1N80P5766d
         7wOStgIvDzy79DVfE0ZKD915fLSe1DZCF/fAM=
Received: by 10.103.40.5 with SMTP id s5mr1372733muj.133.1212744497517;
        Fri, 06 Jun 2008 02:28:17 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.247.141])
        by mx.google.com with ESMTPS id s10sm6797014mue.16.2008.06.06.02.28.13
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Jun 2008 02:28:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v4p884dlh.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84044>

On Tue, 5 Jan 2008, Junio C Hamano wrote:

> When the final blame is laid for a line to a <commit, path> pair, it also
> gives a "previous" information to --porcelain and --incremental output
> format.  It gives the parent commit of the blamed commit, _and_ a path in
> that parent commit that corresponds to the blamed path --- in short, it is
> the origin that would have been blamed (or passed blame through) for the
> line _if_ the blamed commit did not change that line.
[...]
> +	if (suspect->previous) {
> +		struct origin *prev = suspect->previous;
> +		printf("previous %s ", sha1_to_hex(prev->commit->object.sha1));
> +		write_name_quoted(prev->path, stdout, '\n');
> +	}

What happens if attributed (blamed) commit is "evil merge"?
Would git-blame emit multiple "previous <sha-1 of commit> <filename>"
headers?
-- 
Jakub Narebski
Poland
