Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F4AC433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 09:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380070AbiAYJ2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 04:28:12 -0500
Received: from smtp49.i.mail.ru ([94.100.177.109]:33552 "EHLO smtp49.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1573566AbiAYJY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 04:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=VIUrUSsUJSy5jF0DObAeBzBWPFA9xZ8mAeQ+Vz9SGc4=;
        t=1643102664;x=1643708064; 
        b=d5ucKx1ytzNw0I+U4Kn9e5Ho3S5kGlwqHp1akeP4wao7KSf7IeGjaVxDRzPUj4Ae/80S2fmgJZAGnJA1pi8rb9uP+QdIwgKisi7Ef3b/EyKLz0ywaJP103/k84G6Sjdim/NN9Xkja9L+IqmEcCxXNJmER5t8zkvtsz0GLu+/0Ic=;
Received: by smtp49.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1nCI3o-0005GB-P6; Tue, 25 Jan 2022 12:24:21 +0300
Date:   Tue, 25 Jan 2022 12:24:19 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] shell: local x=$1 may need to quote the RHS
Message-ID: <20220125092419.cgtfw32nk2niazfk@carbon>
References: <xmqqsftc3nd6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsftc3nd6.fsf@gitster.g>
Authentication-Results: smtp49.i.mail.ru; auth=pass smtp.auth=kostix@bswap.ru smtp.mailfrom=kostix@bswap.ru
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9AA78FDF62ECAE61F291BE8FFA68662AA8F0E5FECAE10260C182A05F538085040AED54BB5B159FDCCB2001DB96C856459CF02A5D05229D3E88232FFC786B1CF04
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE77633BACAB33B9508C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE795530B80AF2ADB7BEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BEBC5CAB6D411FFA635BDA14631DBE550088534F94FBDDAC5CC7F00164DA146DAFE8445B8C89999728AA50765F7900637CAEE156C82D3D7D9389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8744B801E316CB65FF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C996A9F7B0561EE4703F1AB874ED890284AD6D5ED66289B52698AB9A7B718F8C46E0066C2D8992A16725E5C173C3A84C3467544149CF7516CBA3038C0950A5D36B5C8C57E37DE458B0BC6067A898B09E46D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7A3CCBC2573AEBDE1C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A5FA355A5983BBFCB2D5CF031A2D2843B5F02B1F6D437DDC27D59269BC5F550898D99A6476B3ADF6B47008B74DF8BB9EF7333BD3B22AA88B938A852937E12ACA75B742A0F936AD8A56410CA545F18667F91A7EA1CDA0B5A7A0
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D340EEB18E491831571609171A1214F35E4861738BB3150862806C08962843412B255BD5C985206E4531D7E09C32AA3244C2040A13A5C9B65698EAFBCF30E3938C4CE0B41342B755BCD729B2BEF169E0186
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojF0Kx79yI7sW3cMGqZ80gdw==
X-Mailru-Sender: 7E479B994E4F3A2CC35291DD34DB74CF71D282678FCA5EB783F92F4A3112E0DB2E6B9B7B027550502F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 24, 2022 at 12:11:33PM -0800, Junio C Hamano wrote:

> Even though this message ends with a patch that could be applied to
> your tree, it is not for application at all.  It is to demonstrate a
> potential problem in the code in our tree. 
> 
> While I was playing with the "Linux development environment (beta)"
> on one of my Chromebooks, I say its default /bin/sh (which is Dash
> 0.5.10) mishandled this construct:
> 
> 	func () {
> 		local x=$1
> 		clobber x and nothing else and feel safe
> 		message="I expect this to be visible by the caller"
> 	}
> 
> 	func "a message"
> 	use "$message"
> 
> It assigned 'a' to $x in the function, DECLARED the varilable
> $message as local to the function, hence the caller after func
> returned did not see what I intended to see in $message.
> 
> The breakage is subtle; unless you have a character in $1 that would
> not make a valid variable name, you won't get any error message yet
> the program would behave in an unexpected way.

Sorry, I might have not followed the entire thread, but assignment in
`local` is a bashism, and dash can only handle the declaration part with
`local`, not assignment; hence the safe code should read

  local x
  x="$1"

To cite the dash manual page:

| Variables may be declared to be local to a function by using a local
| command.  This should appear as the first statement of a function, and the
| syntax is
| 
|    local [variable | -] ...
| 
| Local is implemented as a builtin command.
| 
| When a variable is made local, it inherits the initial value and exported
| and readonly flags from the variable with the same name in the surrounding
| scope, if there is one.  Otherwise, the vari‐ able is initially unset.  The
| shell uses dynamic scoping, so that if you make the variable x lo‐ cal to
| function f, which then calls function g, references to the variable x made
| inside g will refer to the variable x declared inside f, not to the global
| variable named x.
| 
| The only special parameter that can be made local is “-”.  Making “-” local
| any shell options that are changed via the set command inside the function
| to be restored to their original values
| when the function returns.

