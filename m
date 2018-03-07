Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58E661F404
	for <e@80x24.org>; Wed,  7 Mar 2018 22:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934286AbeCGW5n (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 17:57:43 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:42328 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934135AbeCGW5m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 17:57:42 -0500
Received: by mail-wr0-f171.google.com with SMTP id k9so3807709wre.9
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 14:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=46yftvOjvhM8eEWGjqBqkNNiWLxAYtc/6zagQjIomeQ=;
        b=CePW5N/pgpESEz+GrQxB/dxHYZAKGZYPnF5lnBjOYFopa4N4HBWAswHQhphHG8Ldbe
         0oWUW/B19L0tgMYTJwARhHqWKojjqM7aywMUNL0+2KDRCmDhVlsIui0FgLfIlSNVBVpe
         KYLug7RiR18ricwZMkLW9FGwmQGRqqxYbPghqENcgXlCeLqP2PnXXE4AUMhj4cfKIC28
         cE8SkMd6tSljJia0EuMzEs1YWYmQaYr5Qo0kc6NOeWQ1lQOePaThapb4v1lvJBJ6kmNC
         0gNyzv17HAgGeNzZtad2hKWG1Jpv4h+zk8Lyjckkv712xK8O0SsRbeVYQDVGGgA7I3As
         ITRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=46yftvOjvhM8eEWGjqBqkNNiWLxAYtc/6zagQjIomeQ=;
        b=IoQgTLM/vq5yi7imkRjEZtthvQ390UTORefQjHQOQG6EjRKXiphUyC6zZe37UJT/oD
         r8kCoZoJVEgKvYZte5wrg4YG4wd+9TZDTj5i29703ZDNQgBlV86ZTZN0sCUBrJbxMady
         HCxawMLJtZofVjMVTY2nMyGlbDuW+SPX/3fU4EKVS+6/V8UND236EmHjOgwt0TaXo2//
         4ZuNEJI4czeLAVh76OOMElgpFNr9wUEREcDKMLQZhAzGt7SctOqjb293ergaeVRK13hH
         zxT2edsNPPZCF2knHANw+24gQXZ5ggGcW6+mGIVFP7MfcFq0VrRoF39SbddSFvD9cwnj
         8eCQ==
X-Gm-Message-State: APf1xPB1BSqhdwE9rIkMlEd967JZRm8Hns50wgMKCxooZbvODM4MUj3V
        NCOSsfkuWiSS6ndGzzJ8/HY=
X-Google-Smtp-Source: AG47ELukt0ECSBm/KnXE97BKR00UDlUdMou8DY1xg5li/KU4cuxnfzP2MJ45H2JrML8mSYEeiMu/yw==
X-Received: by 10.223.163.157 with SMTP id l29mr20112843wrb.239.1520463460937;
        Wed, 07 Mar 2018 14:57:40 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t135sm11867550wmt.44.2018.03.07.14.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Mar 2018 14:57:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v10 6/9] convert: add 'working-tree-encoding' attribute
References: <20180307173026.30058-1-lars.schneider@autodesk.com>
        <20180307173026.30058-7-lars.schneider@autodesk.com>
        <CAPig+cSvC1a5EaDfFZdJU74mZz84M=CkeOJLSDxFdXKcJYyzEw@mail.gmail.com>
        <66370A41-A048-44E7-9BF8-4631C50AAE63@gmail.com>
Date:   Wed, 07 Mar 2018 14:57:40 -0800
In-Reply-To: <66370A41-A048-44E7-9BF8-4631C50AAE63@gmail.com> (Lars
        Schneider's message of "Wed, 7 Mar 2018 23:56:33 +0100")
Message-ID: <xmqqr2ovxzmj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Nice catch. What do you think about this solution using is_encoding_utf8()
> from utf.c?

That helper was invented exactly for a case like this, I would
think.
