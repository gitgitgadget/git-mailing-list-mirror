From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git merge --abort
Date: Tue, 24 Feb 2009 02:53:34 +0100
Message-ID: <200902240253.35470.jnareb@gmail.com>
References: <43d8ce650902190205yc2274c5gb8e658c8608267ff@mail.gmail.com> <43d8ce650902230441n51c9e5a8h722682cda778aa7a@mail.gmail.com> <7vvdr0obuj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: John Tapsell <johnflux@gmail.com>,
	Bryan Donlan <bdonlan@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 02:55:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbmVv-000727-3j
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 02:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbZBXBxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 20:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753043AbZBXBxr
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 20:53:47 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:54586 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbZBXBxq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 20:53:46 -0500
Received: by fg-out-1718.google.com with SMTP id 16so37880fgg.17
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 17:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VuMd6li+4OtSQMtmvIiaCl460q+ZB+4airRwzRlkjRA=;
        b=F37EVBTeIP0XQ2n+c61DYzZsnGOxZIXq0h9ZeylEN/MfI9cIBBNDGTFdVTTqgTjiD6
         ob0/qMzWrccG6dk6stkAWeVSmOUT1imPpASBYk4uMOpYRqWBQul4X7GAcprd8UmY1/uS
         474WJy+31mWXBZ4eJblykj3Qr0J6u7rAIWZKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=hYafnglxt4sfcLk0LBEP8xdPff0nSGnLbFcpdIiIFfmEuMec5rF3JwMsKozFQ8ehjL
         bSw/5lLrBU4zcyrSxoXFyhqQN45on0fTh6RUlSP9HFJDoIW/0L53oKtzxPoml8NERBHf
         zzH9VQQn63nrZfhYrlDNvmzPkWjTrgwTCrzsE=
Received: by 10.86.92.7 with SMTP id p7mr3297084fgb.74.1235440423390;
        Mon, 23 Feb 2009 17:53:43 -0800 (PST)
Received: from ?192.168.1.15? (abve227.neoplus.adsl.tpnet.pl [83.8.202.227])
        by mx.google.com with ESMTPS id d6sm723801fga.59.2009.02.23.17.53.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Feb 2009 17:53:42 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vvdr0obuj.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111195>

Junio C Hamano wrote:
> John Tapsell <johnflux@gmail.com> writes:
> 
> > It sounds like we have some sort of plan then.  Will Nana's patch be
> > committed into mainline git?  Then we can add the --abort porcelain
> 
> I do not know what plan you are talking about, but that's not how the
> development works.  If something is merged to 'pu', and you have a cool
> feature you would want to take advantage of it, you can build your cool
> feature on top of that particular topic.  If the result looks reasonable
> they would cook for a while in 'next' for further polishing and then
> finally go to 'mainline'.
> 
> I personally did not think "--keep" would need to be be part of a
> reasonable "merge --abort" implementation, but I may have missed some
> description of a viable design discussed on the list.

My idea was that merge would do the following:

  $ <save stash into MERGE_STASH or similar, no reset>
  $ <do a merge>

Then we have two possibilities:

  # merge failed with conflicts
  $ git merge --abort (would unstash MERGE_STASH and delete it)

  # we created merge conflict
  $ <MERGE_STASH is removed together with MERGE_HEAD>

-- 
Jakub Narebski
Poland
