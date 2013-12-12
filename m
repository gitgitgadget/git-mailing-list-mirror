From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: I have end-of-lifed cvsps
Date: Thu, 12 Dec 2013 15:58:19 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20131212205819.GA18166@thyrsus.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com>
 <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com>
 <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <20131212171756.GA6954@inner.h.apk.li>
 <20131212182932.GB16960@thyrsus.com>
 <CACPiFCJ22xiedXAoQktMLd=gASgD0NS24Pya9TvCo9aQP5JaBQ@mail.gmail.com>
 <20131212193918.GA17529@thyrsus.com>
 <CACPiFCLXeK9DH=f80ReSmYHJ7zjOn-D2zvs3WmdiV-k=wBGgjA@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 12 21:58:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrDKz-0002fJ-6Y
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 21:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776Ab3LLU6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 15:58:21 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:41883
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab3LLU6U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 15:58:20 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id D7A3C380445; Thu, 12 Dec 2013 15:58:19 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CACPiFCLXeK9DH=f80ReSmYHJ7zjOn-D2zvs3WmdiV-k=wBGgjA@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239245>

Martin Langhoff <martin.langhoff@gmail.com>:
> If someone creates a nonsensical tag or branch point, tagging files
> from different commits, how do you handle it?
> 
>  - without commit ids, does it affect your guesses?

No.  Tagging is never used to deduce changesets. Look:

/*
 * The heart of the merge operation; detect when two
 * commits are "the same"
 */
static bool
rev_commit_match (rev_commit *a, rev_commit *b)
{
    /*
     * Versions of GNU CVS after 1.12 (2004) place a commitid in
     * each commit to track patch sets. Use it if present
     */
    if (a->commitid && b->commitid)
	return a->commitid == b->commitid;
    if (a->commitid || b->commitid)
	return false;
    if (!commit_time_close (a->date, b->date))
	return false;
    if (a->log != b->log)
	return false;
    if (a->author != b->author)
	return false;
    return true;
}

>  - regardless of commit ids, do you synthesize an artificial commit?
> How do you define parenthood for that artificial commit?

Because tagging is never used to deduce changesets, the case does not arise.

I have added an item to my to-do: document what the tool does with
inconsistent tags.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
