From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v3 3/4] git-submodule: New subcommand 'summary' (3) - limit summary size
Date: Fri, 7 Mar 2008 09:50:55 +0800
Message-ID: <46dff0320803061750x70d059a2yaf1e5751e9c62150@mail.gmail.com>
References: <1204481710-29791-1-git-send-email-pkufranky@gmail.com>
	 <1204481710-29791-3-git-send-email-pkufranky@gmail.com>
	 <7v7iggitsd.fsf@gitster.siamese.dyndns.org>
	 <46dff0320803051824t75f39524uda9bc864a9fe4435@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 02:52:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXRkX-0001iu-6c
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 02:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbYCGBu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 20:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbYCGBu5
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 20:50:57 -0500
Received: from an-out-0708.google.com ([209.85.132.245]:5825 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbYCGBu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 20:50:56 -0500
Received: by an-out-0708.google.com with SMTP id d31so54677and.103
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 17:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5IxjOKVK6IMjV0F14yYBdjRrg6G1lAyaDuiw/aOIMWE=;
        b=eUu3qW8Q5JzUPghW4mtHjNaVEgWg1t77D4fHb/DZqPoUrN5BuAmTnaEh32HNAzN1btJJzOcBIb9wwkWyTNDb6ck+43reN/TXwaPDgNXJpy5nF+0JhWdRPDWsuUem+CFuFU+RBKD3RsUbKKHZBf1Yh6VKkmDgue34wZi6Fp9ELyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YWO1p+2qCu+S805fFGvgRbCwVNk0fHiW/k96Wiu8XoKr3QQGkTPKEZlTAW5LE9HJj2XEAc8+LH1n+n58iq7rMYIrrk6Q/DlGGYNfN44K//Kvg8Y8eCe+ZfrZTcQtx7R6NqGxZN16oMSrIapBGdUugWcoLWdLK1lvGnV07vebSiE=
Received: by 10.100.242.20 with SMTP id p20mr1477140anh.4.1204854655861;
        Thu, 06 Mar 2008 17:50:55 -0800 (PST)
Received: by 10.100.5.18 with HTTP; Thu, 6 Mar 2008 17:50:55 -0800 (PST)
In-Reply-To: <46dff0320803051824t75f39524uda9bc864a9fe4435@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76449>

On Thu, Mar 6, 2008 at 10:24 AM, Ping Yin <pkufranky@gmail.com> wrote:
> On Thu, Mar 6, 2008 at 8:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  > Ping Yin <pkufranky@gmail.com> writes:
>  >
>  >  > This patch teaches git-submodule an option '--summary-limit|-n <number>'
>  >  > to limit number of commits in total for the summary. Number 0 will disable
>  >  > summary and minus number means unlimted (the default).
>  >
>  >  I really doubt showing the bottom one specially makes sense.
>  >
>  >  Why not just read from
>  >
>  >         git log '--pretty=%m %h %s' --left-right --topo-order A...B
>  >
>  >  and show N top commits from each?

I doubt '%h' is useful and it may result in overlong message lines.
Is '--topo-order' expensive when only show top N commits?
I prefer to use

    git log --pretty='format:%m %s' --left-right --first-parent A...B

for modificated modules, and

   git log -1 --pretty='format:> %s' $sha1_dst
   git log -1 --pretty='format:< %s' $sha1_src

for added ( or blob -> submodule typechange) and deleted
( or submodule -> blob typechange) modules separately.




-- 
Ping Yin
