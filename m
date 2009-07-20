From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] Add git svn gc command
Date: Mon, 20 Jul 2009 11:02:15 +0200
Message-ID: <9b18b3110907200202kbb78c8dm43e0451900e4f2fb@mail.gmail.com>
References: <8E0EFA3B-E8C0-4030-8BAE-E8EF65694031@gmail.com>
	 <20090720075929.GA5591@dcvr.yhbt.net>
	 <9b18b3110907200115p4c0c3b45nc6c7f31b34ceff0c@mail.gmail.com>
	 <20090720083621.GA3237@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robert Zeh <robert.a.zeh@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jul 20 11:05:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSooH-00084o-V1
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 11:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930AbZGTJCR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jul 2009 05:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752689AbZGTJCQ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 05:02:16 -0400
Received: from mail-yx0-f184.google.com ([209.85.210.184]:50556 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbZGTJCQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2009 05:02:16 -0400
Received: by yxe14 with SMTP id 14so3419248yxe.33
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 02:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KBp2i7Btp3tm7+6pgAyReC6Uqjt54DOxb+NAv6fCC1s=;
        b=HdkrTrtO0QJEfa5QcKvtPEbPI1ZckRE6vBnx/Zoqjb6WIjsXq+WPFhtXO+b7uDNh0w
         8DmyMsNsfMZbeo2hOQS15x8pOTd8xHXSFxZPvU0a5r5PIqar4qXtwYn71Yt6tS6l5/Nq
         b6GU5+G35JdSfAJWG1HFVP7T4kLiGGTAlXxWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uDkvLjCT0sz/eids254so/Vx4RsBMtWs6p0nni6Ad7xgPd2Ke/T8AuPuU/wpg20yt+
         ZKEicZMZqsVNCOEX3qZgUlVsZ8iqq+IxCSHxMeMP6xft7TZqtEG1yor/AjO6MJbTYMhY
         XgnZk5geLM1zp/ph8jsSFQi80zdrp9v0rdm/0=
Received: by 10.231.36.68 with SMTP id s4mr175922ibd.47.1248080535271; Mon, 20 
	Jul 2009 02:02:15 -0700 (PDT)
In-Reply-To: <20090720083621.GA3237@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123581>

2009/7/20 Eric Wong <normalperson@yhbt.net>:
> demerphq <demerphq@gmail.com> wrote:
>> 2009/7/20 Eric Wong <normalperson@yhbt.net>:
>> > Robert Zeh <robert.a.zeh@gmail.com> wrote:
>> >> --- a/git-svn.perl
>> >> +++ b/git-svn.perl
>> >> @@ -35,11 +35,14 @@ push @Git::SVN::Ra::ISA, 'SVN::Ra';
>> >> =A0push @SVN::Git::Editor::ISA, 'SVN::Delta::Editor';
>> >> =A0push @SVN::Git::Fetcher::ISA, 'SVN::Delta::Editor';
>> >> =A0use Carp qw/croak/;
>> >> +use Compress::Zlib;
>> >
>> > I'd "require" Compress::Zlib lazilly so it's not loaded at startup=
=2E
>> > It's not a stock component of Perl and not needed for the majority=
 of
>> > commands.
>>
>> Actually, it has been a core component since 5.9.3
>
> Ah thanks for pointing that out, I didn't notice my 5.10.x install ha=
d
> it. =A0Nevertheless, git svn needs to continue supporting 5.8.x for a
> while longer.

I guess something like:

my $can_compress=3D eval "require Compress::Zlib; 1";

would be the right solution.




--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
