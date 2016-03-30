From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git-apply does not work in a sub-directory of a Git repository
Date: Wed, 30 Mar 2016 16:33:48 +0700
Message-ID: <CACsJy8C3QtVmqS_HPHjdWhBssJkZ197yz9uA3XAb-TDiOhEUmg@mail.gmail.com>
References: <CACsJy8CTix-ZwN04MwYTB+JEtDCV27QVf7_0vWmhUSVCwU29Jg@mail.gmail.com>
 <1458820579-31621-1-git-send-email-pclouds@gmail.com> <xmqq8u17akgn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Mehul Jain <mehul.jain2029@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 11:34:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alCW8-0007XG-D3
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 11:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbcC3JeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 05:34:20 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33711 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbcC3JeT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 05:34:19 -0400
Received: by mail-lb0-f178.google.com with SMTP id u8so27828861lbk.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 02:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nQI/QjPAfStdaaDGmURAGN7PZSvDVSIwLsZRtw8ucCg=;
        b=cerI7CeSBnMacQUuCzGU8L3fuS3cse8mjZgprD/y/ewCrjoNsfqYQWHP5g16lewdKb
         hqijmJXnUOuXjFOi13VA8WvHOK2aGQKtMZQ1Z2qRnNK6PUl44GW0MFq+8N77N627fFoI
         cjr9v76x4Lco13VKXiNVXwP7vdLxTN8Xvw88PU5GNH2k0FlQmw9mPFBcBrJZErcT6UTD
         tZKmLoaOi1iZueptq4Y96TCdmnbkyCdnU71hJgjhES9XAdZ+w/xO/Z/U4xEe+S4phWXB
         qqU5SSiFZ3sJc1hxzeCc83G7wV8w7s2Jj192xRxh0J0FwvOyG9/Hgy4PBQgc4ILxJjou
         cRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nQI/QjPAfStdaaDGmURAGN7PZSvDVSIwLsZRtw8ucCg=;
        b=jYK3rD60y106xjI6YXRkdtjvEjU8oGnhPtb6Ts6RYLz3GgF+OGVl64Y5MbztH44HSo
         B87Rfe+D3H+rPTmuGWU/9qEfsa+BRC145riPmiG1GfJxAgQNO94O+Tu0/3jTeg9Lsywv
         0BMvr7nIxadwJTqpHPkRMvpBpJvdLSU+fuH582k1qEArC6Tb7a7RPStP2dx6vI64Xmtj
         gfsb6We1CTgQZCgl1YA5K9/vTFr6Mq+wCwE5dMhh54TIbvUMBQMHu4gQqzShDhLQKKFl
         a76Ya6hPiNdwf56X5qfF34R8S+S7DAKr4IUVTSnc4ki3P+9dRgIodc1anV6mIjLIemz8
         Fpbg==
X-Gm-Message-State: AD7BkJIPAwLsVOyVLDYIz/kwg3ZdLsVtq0wxFFjVJq8V8heGUAku+iIhRY5IwG1sk6vTnFd4YO0jFTS1RgkOKA==
X-Received: by 10.112.157.105 with SMTP id wl9mr3317890lbb.137.1459330457785;
 Wed, 30 Mar 2016 02:34:17 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 30 Mar 2016 02:33:48 -0700 (PDT)
In-Reply-To: <xmqq8u17akgn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290282>

On Thu, Mar 24, 2016 at 11:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> So a better alternative may be to conditionally disable the "Paths
> outside are not touched regardless of --include" logic, i.e. we
> exclude paths outside by default just as before, but if there is at
> least one explicit "--include" given, we skip this "return 0".
>
> That way, we do not have to commit to turning --include/--exclude to
> pathspec (which I agree is a huge change in behaviour that may not
> be a good idea) and we do not have to add "--full-tree" that is only
> understood by "apply" but not other commands that operate on the
> current directory by default.

Suppose I don't like git-apply's default behavior, I make an alias.ap
= "apply --include=*". So far so good, but when I want to limit paths
back to "subdir" (it does not have to be the same as cwd), how do I do
it without typing resorting to typing "git apply" explicitly ? I don't
see an option to cancel out --include=*. For "git ap --exclude=*
--include=subdir" to have that effect, we need to change

for (i = 0; i < limit_by_name.nr; i++) {

in use_patch() to

for (i = limit_by_name.nr - 1; i >= 0; i--) {

Simple change, but not exactly harmless.

Off topic, but --include/--exclude should be able to deal with
relative path like --include=../*.c or --include=./*. I guess nobody
has complained about it, so it's not needed.
-- 
Duy
