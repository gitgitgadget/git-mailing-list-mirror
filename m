From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rebase: pass --signoff option to git am
Date: Mon, 6 Dec 2010 11:28:47 -0600
Message-ID: <20101206172847.GA6272@burratino>
References: <1290856542-6070-1-git-send-email-giuseppe.bilotta@gmail.com>
 <ADC46761-DFF5-486D-B604-05BA8C8631EB@sb.org>
 <AANLkTindvz=7OmYaL6AL_oAj50U9PLnRrbSpjgR92z7C@mail.gmail.com>
 <AANLkTinnn_QnBJ8AZT9ZB+ZHVRDZV0tDret=YQeyfa01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>, git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 18:29:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPes5-0002Lj-IV
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 18:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258Ab0LFR25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 12:28:57 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48022 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab0LFR25 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 12:28:57 -0500
Received: by qwd7 with SMTP id 7so1499072qwd.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 09:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DfwWJ4WD10yi/blT7mIeClOHH9tnYPgnzdWikAD9Fpk=;
        b=ORWYRUIR7DZ+B3OBI8y/rbanb4wyKg/PaJKPcfPJCHJ64hsrWPICtsGQz7UHg6Jyvr
         ATM8EWqo07OV9NNVq52ze4p7QAi2ryNvWUYoAgtNz3S1b6hOcdlUzxyk8NIefsXkwhyD
         bbd96BKYAXKvVsACZwiWyZ2j0GYHAAxVCs7rU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=l4kVlzuiFFW5ZU3m2owHwShS5Y3lBxl76EDbPI9rrfpdect0JoRi06f6oiu3q41Ykp
         J3rKVo05+7I4lrmMAr+PKdvfe1RK0J6bcZGQbGNBWoTSg9jdE9r7R4LNXzVU/mkJcz+l
         si/iYYQ57sCp19lG/HHEWBxpX0PLNC//igVu4=
Received: by 10.220.188.135 with SMTP id da7mr1689144vcb.2.1291656536362;
        Mon, 06 Dec 2010 09:28:56 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id p28sm568167vcr.46.2010.12.06.09.28.53
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 09:28:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinnn_QnBJ8AZT9ZB+ZHVRDZV0tDret=YQeyfa01@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163000>

Giuseppe Bilotta wrote:

> For what it's worth, somebody on #git just asked how to signoff a
> bunch of patches. The answer was to rebase -i and sign off each one of
> them.

How I would do it in existing git:

	git branch oldhead
	git reset --keep base
	git log --oneline --graph HEAD..oldhead;	# the right patches?
	git cherry-pick -s HEAD..oldhead
	git diff oldhead

Or without multiple-cherry-pick, maybe:

	git branch oldhead
	git reset --keep base
	git format-patch -k --stdout HEAD..oldhead >series
	git am -s -3 -i series;	# the right patches?
	git diff oldhead

No opinion on the automatic-signoff-in-rebase here.
