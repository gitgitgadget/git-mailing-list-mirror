From: Esko Luontola <esko.luontola@gmail.com>
Subject: Re: Cross-Platform Version Control
Date: Tue, 12 May 2009 20:56:55 +0300
Message-ID: <D1E08DA2-8D8E-4D45-A50A-F32E3448D6E9@gmail.com>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <20090512151403.GS30527@spearce.org> <alpine.DEB.1.00.0905121808480.4447@intel-tinevez-2-302>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 12 19:57:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3wE7-00048G-EQ
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 19:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbZELR5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 13:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753723AbZELR47
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 13:56:59 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:27985 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685AbZELR46 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 13:56:58 -0400
Received: by fk-out-0910.google.com with SMTP id 18so63118fkq.5
        for <git@vger.kernel.org>; Tue, 12 May 2009 10:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=fWR4kdm3X41mS7g6LqG2D/WzC6cz6eBo3s7Q5XusTaQ=;
        b=Vdnvsf9lnCclOYvHizNGMLiVNlj6I6Pc2gVxLOEDJ7zSAUoglQbMFtxCH7yePuimvB
         hO48efPkCIfN6wUek6p0zCkYi5jhQNE4VwyMsGgqdAh1njROh3ZWR0yxzYIqnZnBFVlI
         ZOL8I/FtXSvp/N2xC3K3ruGmPbwDywTG14GG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=FZzb1OLf+JcHHVqy/9WREBWCEUd66e5ZPAxAoNgyPfOUQxYmAYjJITTzI5eOpVKWVl
         gJ1uBJO9hFvhzCKf5zn1Xcd2YLFzQGrnctXjHe8OHSM9yZZCHx8WFHsZGvimUIHQv3Kr
         yN94+7GQRIOtbSCMn/WVj1iO2fW39hWQ3DAVI=
Received: by 10.103.197.17 with SMTP id z17mr800728mup.19.1242151018204;
        Tue, 12 May 2009 10:56:58 -0700 (PDT)
Received: from ku-hupnet59-74.hupnet.helsinki.fi (vallila-gw.hupnet.helsinki.fi [128.214.20.122])
        by mx.google.com with ESMTPS id i7sm404977mue.18.2009.05.12.10.56.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 May 2009 10:56:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0905121808480.4447@intel-tinevez-2-302>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118936>

On 12.5.2009, at 19:13, Johannes Schindelin wrote:
> As to storing all file names in UTF-8, my point about Unicode being  
> not
> necessarily appropriate for everyone still stands.
>
> UTF-8 _might_ be the de-facto standard for Linux filesystems, but
> IMHO we should not take away the freedom for everybody to decide  
> what they
> want their file names to be encoded as.
>
> However, I see that there might be a need to be able to encode the  
> file
> names differently, such as on Windows.  IMHO the best solution would  
> be
> a config variable controlling the reencoding of file names.

Exactly. The system should not force the use of a specific encoding.  
It should only offer a recommendation, but be also fully compatible if  
the user uses some other encoding.

That's why it's best to always store the information about what  
encoding was used. It shouldn't matter, whether the data is encoded  
with ISO-8859-1, UTF-8, Shift_JIS, Big5 or some other encoding, as  
long as it is explicitly said that what the encoding is. Then the  
reader of the data can best decide, how to show that data on the  
current platform.

A config variable for defining, that what encoding should be used when  
committing the file names, would make sense. Git should also try to  
autodetect, that what encoding is used in its current environment. In  
the case of UTF-8, you should also be able to specify which  
normalization form is used (http://www.unicode.org/unicode/reports/ 
tr15/), or whether it is normalized at all.

For example, it should be possible to configure Git so, that when a  
file is checked out on Mac, its file name is converted to the current  
file system's encoding (UTF-8 NFD, I think), and when the file is  
committed on Mac, the file name is normalized back to the same UTF-8  
form as is used on Linux (UTF-8 NFC).

It would be nice to have config variables for saying, that all file  
names in this repository must use UTF-8 NFC, and all commit messages  
must use UTF-8 NFC (with Unix newlines). Then the Git client would  
autodetect the current environment's encoding, and convert the text,  
if necessary, to match the repository's encoding.

- Esko
