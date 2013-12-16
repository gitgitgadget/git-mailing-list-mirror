From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 02/21] path.c: rename vsnpath() to git_vsnpath()
Date: Mon, 16 Dec 2013 09:11:47 -0800
Message-ID: <20131216171147.GA28604@google.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1387018507-21999-1-git-send-email-pclouds@gmail.com>
 <1387018507-21999-3-git-send-email-pclouds@gmail.com>
 <52ACBE2B.3040909@ramsay1.demon.co.uk>
 <CACsJy8BdLt8ZUU2z4LAgTcfXUjruFaOFsvrv6dSziZVizAopGA@mail.gmail.com>
 <52AE1B5E.6020506@ramsay1.demon.co.uk>
 <CACsJy8AJT5XXyJvVi_6Gjrn=AqA1M9KWY_62p=d3CPjg7nXFWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 16 18:12:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsbiF-0007bi-AF
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 18:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab3LPRMC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 12:12:02 -0500
Received: from mail-yh0-f44.google.com ([209.85.213.44]:39589 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583Ab3LPRL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 12:11:58 -0500
Received: by mail-yh0-f44.google.com with SMTP id f64so3932507yha.3
        for <git@vger.kernel.org>; Mon, 16 Dec 2013 09:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gVjCzvcqpuCww0rOcZKAeaL2wrprDlrSknCo/PPupAE=;
        b=jRkz88fnab+oiMQiXMG2h6OEi2vTtTgBLi0Jh16c3Qa+OY7kDzeJ1eSSq+W7bjJNK4
         SIE7BRxPsjccj6w0kfD1X/fnNoLEunqMp2x7TmifjRIa3B90i2h4jw8EQ7lC00jqNNZ3
         IAdcn8wTpVj//Vk2P2MTydxfefEYPAzkZJDtm/+VzMi18o/rkSt5x6cOloXakwuB6k15
         lMI0Aw8Win84QvJ7Uzg01EElkiSetEk9a2kEwV3EsVNXDNm/QGm5EYJ540Z6JgeECCCG
         KopAOnjE7eeavHRikNlZehB2ZJqpQ0i5Phy2jzx3JX0hj4XVDBj8sbT8CeY/gLV68T4Z
         DKEQ==
X-Received: by 10.236.194.136 with SMTP id m8mr7420490yhn.60.1387213915731;
        Mon, 16 Dec 2013 09:11:55 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id w45sm19653120yhk.4.2013.12.16.09.11.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 16 Dec 2013 09:11:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACsJy8AJT5XXyJvVi_6Gjrn=AqA1M9KWY_62p=d3CPjg7nXFWw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239339>

Duy Nguyen wrote:
>>> Ramsay Jones wrote:

>>>> :-D I renamed this _from_ git_vsnpath() in commit 5b3b8fa2 ("path.c: Remove the
>>>> 'git_' prefix from a file scope function", 04-09-2012), because ... well it's a
>>>> file scope function! (i.e. the git_ prefix implies greater than file scope).
>>>> I'm not very good at naming things, so ...
[...]
> OK I go with this. I think it makes sense
>
> vsnpath -> do_git_path

I think this renaming would be still losing clarity --- it loses the
information that this is the vsnprintf-like variant of git_path.

Do we actually have a convention that functions with git_ prefix
should be global?  If git_path were not global, would it have to be
renamed?  If git_vsnpath should be renamed to avoid mistaking it for
git's replacement of a hypothetical standard library vsnpath function,
shouldn't git_path, git_pathdup, etc be renamed for the same reason as
well?

> its three callers are
>
> git_vsnpath -> strbuf_git_path (it's updated to take strbuf)
> git_path
> git_pathdup

Yeah, independently of everything else, a strbuf variant sounds nice.

Thanks,
Jonathan
