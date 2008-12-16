From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFCv4 3/3] gitweb: link to patch(es) view from commit and log views
Date: Tue, 16 Dec 2008 12:14:26 +0100
Message-ID: <cb7bb73a0812160314t4a74dbb3r4748ad9190a88bd6@mail.gmail.com>
References: <1228575755-13432-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200812160203.29425.jnareb@gmail.com>
	 <cb7bb73a0812160202n1f4f7f4fi7f71455eb42bcd31@mail.gmail.com>
	 <200812161114.35336.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 12:15:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCXu0-0006JU-Fi
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 12:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbYLPLO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 06:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752738AbYLPLO3
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 06:14:29 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:53258 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbYLPLO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 06:14:28 -0500
Received: by ewy10 with SMTP id 10so3594812ewy.13
        for <git@vger.kernel.org>; Tue, 16 Dec 2008 03:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qSrVzGBK/Ril2h0dvMfXKE5zIxKMGUuvycZr+0lNgks=;
        b=ZJ4qXmim8n7dgL+OG8crVbI+x+fW8qCEr97mo9i3agXGbMnIqquAZSdXKq/0WZifAQ
         7nPlHrXoz56pD/A/NAPTqMdM5mwIx0PVbFlxiXotH5TIE8pMJmhiLIhExKT1y4IbQNBe
         YxGedz9aYY4cCUx/TAg6H5Kc7i9cSp9C5DGeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WU7LD7vgOospliI1UKLK92aRUDsUAU8wu5QAtKePkzYnDcyLDlwGuz6HkYygoZxE4Z
         OUVqYYNfzhkS3+zYXuynatap3hBc11qqZb4HmfLgUNHLpH6omV0Z5Po0b5sY3n0JoIuZ
         RI4jBqj981V/EBKTZl+7h4W3wCRfVKhjmK3dE=
Received: by 10.210.122.5 with SMTP id u5mr5793528ebc.49.1229426066693;
        Tue, 16 Dec 2008 03:14:26 -0800 (PST)
Received: by 10.210.136.4 with HTTP; Tue, 16 Dec 2008 03:14:26 -0800 (PST)
In-Reply-To: <200812161114.35336.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103270>

On Tue, Dec 16, 2008 at 11:14 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> You lost CC, somehow...

Duh, clicked the wrong button.

>>> I wonder if it would make sense to pass
>>>
>>>   href(..., hash_parent => $commitlist[-1]{'id'}, ...)
>>>
>>> here. But I think having separate "patches" action, with intent being
>>> displaying series of patches, is a better solution. This way you can
>>> see in URL and in the page title (thus also in window title, or in
>>> bookmark name) if it is single patch or patch series (perhaps consisting
>>> of single patch).
>>
>> I'm not sure I'm following you here. Do you mean as in manually adding
>> the parent endpoint to the URL when it's not specified in the log view
>> itself? I think that would change the behaviour for > 100 patches.
>
> First, I meant here that having separate "patches" action is a good
> idea in itself, whether we pass explicitly and always $hash_parent
> parameter here or not.

I'm not too sure about that. Do we pass the actual hash parent, or
just the last patch that would be included due to the patch limit?
This, btw, is an issue that should resolved with patch view: it should
warn when the patch limit is reached before all intended patches are
output. I'm just not sure about how to do it.

> Second, I haven't thought about interaction with (short)log
> pagination; in $patch_max < 0, i.e. unlimited patches, and most
> common case of running 'shortlog' action without 'hp' (hash_parent)
> limiter used, one would make 'patches' limited to page size,
> other unlimited.  On one hand side limiting to page size makes
> "patches" be more of equivalent of current "shortlog" view; on the
> other hand it makes 'unlimited' actually be limited to page size,
> at least in this situation...

Consider that switching from log to shortlog view doesn't respect
pagination (e.g. if you're on page 3 of shortlog and click on log you
go to page 1 of log) I would be inclined to keep patches behaviour
independent of log view pagination.


-- 
Giuseppe "Oblomov" Bilotta
