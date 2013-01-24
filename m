From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] Revoke write access to refs and odb after importing
 another repo's odb
Date: Thu, 24 Jan 2013 08:30:29 +0700
Message-ID: <CACsJy8A1EVJbUsqyqNueEvhvd61VHfuiPL3VXBuAPs2FUw=_dg@mail.gmail.com>
References: <1358948067-2792-1-git-send-email-pclouds@gmail.com> <7v1udbj0kt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 02:31:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyBfM-0006pB-1P
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 02:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952Ab3AXBbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 20:31:06 -0500
Received: from mail-ob0-f170.google.com ([209.85.214.170]:43557 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499Ab3AXBbB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 20:31:01 -0500
Received: by mail-ob0-f170.google.com with SMTP id wp18so9137849obc.29
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 17:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=12otmjNOSINpNRzsFrcg09D3d2ZKDQ0t/SDjUSC5s3U=;
        b=YGNpB6SeInBi8l0uP5u8WiTlAmnM4e6l6nm7hh7kWaFuwjiOWPrWMy9lNUC/MLjDga
         EOuX/kZeHQdebdpTUKoyS9Q8lvK+AOqJUcegJ7AMCs6rn6jp9tljoW014O/9CRfAAuec
         hvLc20GYw7cFql9E8JyjZaa4CXpvuRJFcpKnT7soK7TH98TfCl/Ny/UTdrToosVMIPOZ
         cS3YyrNsf+n5PbOIzxGbzi9N67oOJ+Y2fCzeGA3lZBRbJfFmTu+mD2AxvyRR2zdtOqzr
         g1lr6O2pgMDP0ULB7BtEV7tZF3u2vStzXf8hr/MHKgTlNUVDMKyY7CrYcbqWFsCf5gU1
         7m1w==
X-Received: by 10.182.188.69 with SMTP id fy5mr139001obc.74.1358991060844;
 Wed, 23 Jan 2013 17:31:00 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Wed, 23 Jan 2013 17:30:29 -0800 (PST)
In-Reply-To: <7v1udbj0kt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214383>

On Thu, Jan 24, 2013 at 12:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I however have this suspicion that this will become a losing battle
> and we would be better off getting rid of add_submodule_odb();
> instead operations that work across repositories will be done as a
> subprocess, which will get us back closer to one of the original
> design goals of submodule support to have a clear separation between
> the superproject and its submodules.

It does not have to be subprocess. Thomas Rast did some work on
support multithread access to object db by basically replicating all
datastructure per thread. If that work is complete, we have something
like "odb container" that could be used to access objects from another
repository and it won't contaminate the original odb. The same thing
can be done for ref and index access.
-- 
Duy
