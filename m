From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/23] Preliminary pack v4 support
Date: Wed, 28 Aug 2013 09:30:38 +0700
Message-ID: <CACsJy8AttNxePUG9cKw9ihAmRd=kFpcsgwe2yj_FRQbhc-akCg@mail.gmail.com>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
 <xmqqioyrfa5m.fsf@gitster.dls.corp.google.com> <alpine.LFD.2.03.1308271153370.14472@syhkavp.arg>
 <xmqq8uzndqws.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 28 04:31:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEVXV-0002u7-KB
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 04:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712Ab3H1CbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 22:31:12 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:35773 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab3H1CbM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 22:31:12 -0400
Received: by mail-oa0-f52.google.com with SMTP id f4so6980252oah.11
        for <git@vger.kernel.org>; Tue, 27 Aug 2013 19:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nyuu2HQu2DxBhQmWxUXSudWVKIqv3yUiD5WvNlFhfX0=;
        b=O2JVAsbSQKwrjjb1L1YCllEC6tS29mprLYnUaN3QSHnEbW/swRcIvNKpuw33P54Jgp
         H8iJTpghwH20J6rlofkmZzh8p2RzbHYfch3sMzUj5nqWspMvcOIntjAzh6Xa2heCX/aT
         Hll/0UanM4YmJnjkgaeTlcwZFcS9MNEwEd4z/3J0ICvKBx3X41ErBWgNyUW1qexNP40q
         Epebpbm4nfhOg8WnN4ksbl9Z57arXtkgz0P9nI5DFFirZ8wa4j78BAqxpMII+dxERn+C
         8RionV2Vi5YqqFvvejKx1YIPtGhH8Zcb6420hIDdzQjwF5ALxtJi4aPGmoRTHQe7f/RP
         fwAQ==
X-Received: by 10.182.60.70 with SMTP id f6mr4829523obr.61.1377657069193; Tue,
 27 Aug 2013 19:31:09 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Tue, 27 Aug 2013 19:30:38 -0700 (PDT)
In-Reply-To: <xmqq8uzndqws.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233174>

On Tue, Aug 27, 2013 at 11:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> As you have "0-index" escape hatch for SHA-1 table, but no similar
> escape hatch for the people's name table, I can see why it may be
> cumbersome to fix a thin pack by only appending to a received
> packfile and updating a few header fields, though.

We also need an escape hatch for path name table. But what if we store
appended objects in OBJ_REF_DELTA format where base ref is empty
tree/commit and cached by sha1_file.c? We won't need to update
dictionary tables. Parsing is a bit ugly though (e.g. v3 tree with v2
base) but we have to deal with that anyway because people can have v2
and v3 packs mixed in.
-- 
Duy
