From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Making GIT XML aware?
Date: Tue, 1 Sep 2009 14:06:30 +0000
Message-ID: <32541b130909010706s45031e64ld614802f2b57ce5e@mail.gmail.com>
References: <fcdc4d8bb3b1ee0b1473a48ed79e7c61.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: david.hagood@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 01 16:31:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiUOp-0001fJ-HD
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 16:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754994AbZIAObn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 10:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755009AbZIAObn
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 10:31:43 -0400
Received: from mail-yw0-f188.google.com ([209.85.211.188]:37708 "EHLO
	mail-yw0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426AbZIAObm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 10:31:42 -0400
Received: by ywh26 with SMTP id 26so18818ywh.5
        for <git@vger.kernel.org>; Tue, 01 Sep 2009 07:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=PS0mzE1RNEnkWX/HH8v4hhllF+oLOEMldiCMZBi3qIQ=;
        b=ce0VyPGbYU12en5NNoTUrq37lMCd+w/EK8V16m3R6joWQjmCfJnsITl7MRDNq4GG9L
         DQVkRL/Db2nhWe6mB/1YPRRkAeXwfJRtK6zdOPxxw9SLBaDQ9Ozk+ooKDGSHwetTVa3+
         q3a5PIX/3n+u3B2JUtcIpLajKdZA5S++LxVhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=wXXub8OfUNWs11UPFQU/N8EQWh7B2lL+i4iuDGttfyKxLoLA4z4g1XYUYVtVqkFtML
         USFi2Rp2UdGSWeDJw6yT60QWR9T2L51ngYWX906oBhb4ybVyBVEWBGBUP059vZBF8HMb
         wGfhmUSQVPMyhMxIoGolegmD+YY/01rBnRnmM=
Received: by 10.150.55.42 with SMTP id d42mr10456186yba.244.1251814010061; 
	Tue, 01 Sep 2009 07:06:50 -0700 (PDT)
In-Reply-To: <fcdc4d8bb3b1ee0b1473a48ed79e7c61.squirrel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127538>

On Tue, Sep 1, 2009 at 1:57 PM, <david.hagood@gmail.com> wrote:
> However, it seems to me that if there were some way to plug into GIT's
> merging logic, it would be possible to design an XML aware merging tool
> that might help on this (generalizing: if you could have content-aware
> merging libraries you could make all sorts of merges go more smoothly).
> For the specific case of an XML file, if you could have some way to denote
> tags and/or attributes that are "don't cares" you could address problems
> like I am having. You could also theoretically exploit a knowledge of the
> format to better identify what chunks are changes and possibly track
> motion within the files better.

You have a couple of options here, both of which you can read about in
'man gitattributes'.

If you have "don't care" attributes, that's a good sign that you
shouldn't be storing them *at all*.  You could use the 'filter'
feature of gitattributes to remove them (or convert them to a
constant) on checkin, and regenerate them on checkout.

As for merging algorithms, you can supply a custom one using the
'merge' gitattribute.

> Absent that, is there a way to tell git "in case of an unresolvable merge
> conflict, don't modify the file but put the other version of the file
> somewhere (e.g. filename.other) so that I can use an external tool to
> resolve the differences"? In this case, EA doesn't know how to use the
> standard conflict tags within a file to extract deltas.

You can apparently override this with the 'merge' attribute as well.

Have fun,

Avery
