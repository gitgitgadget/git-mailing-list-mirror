From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv5 12/12] gitweb: gather more remote data
Date: Sat, 23 Oct 2010 18:17:51 +0200
Message-ID: <AANLkTi=7gUAbdRKLCifPidZXdLa8fCENT0=iy5bKAeiA@mail.gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1285344167-8518-13-git-send-email-giuseppe.bilotta@gmail.com> <201009271747.39201.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 18:18:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9gna-0002cg-W3
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 18:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757924Ab0JWQST convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Oct 2010 12:18:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46929 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757920Ab0JWQSM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Oct 2010 12:18:12 -0400
Received: by iwn34 with SMTP id 34so2301528iwn.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 09:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=fIab5bWUdzJT42gumJCFPiMdHghjYWtNHzdbeOKjy30=;
        b=niOBOHPX9dzHdwnGfiudSRvKj0DluY6BnDZ0+y62Uh1bzFjYdGodPbrNQIdd+vUiw7
         xgcThMHlSvjT4jLzytuk/qVqQwi2dbmUEIpzpL3tS9UI2vUAEUsHAOF2Yidpm8xgGy1C
         vLyLrKP8msryGnXhOhAzvXOkISX5QJHI7f5j4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=f0xn/HcMNlAtH6fGDEOe0jSOmmHz3TEYDa3MFumfCWP5napQHdqYz2s/9iAjf6cmsu
         IVv3dZxkT6hU2GBMstWuzTBIhL8LS6qDAta654rsfhyOYCrRttkcFVppEMwOfNQA2Nsg
         R1SSWcNdTQM6OjaF7YVB19xGDv07xO1BiNDe8=
Received: by 10.231.167.196 with SMTP id r4mr3942245iby.29.1287850692000; Sat,
 23 Oct 2010 09:18:12 -0700 (PDT)
Received: by 10.231.149.141 with HTTP; Sat, 23 Oct 2010 09:17:51 -0700 (PDT)
In-Reply-To: <201009271747.39201.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159789>

I'm awfully sorry for the delay in the reply to this email. I got
gobbled up by some real-world stuff just while finishing the review of
the last patch.

2010/9/27 Jakub Narebski <jnareb@gmail.com>:
> On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:
>
> Isn't the most important and visible information the fact that both
> standalone 'remotes' view and 'remotes' section in the 'summary' page
> is now grouped by remotes? =A0This should be explicitely mentioned in=
 the
> commit message. =A0It is not very visible IMVHO in what is written be=
low.

You're right. I've rewritten the message by putting the grouping
layout in the subject and rephrasing the body of the commit to better
describe what happens both in remotes view and in limited summary
view.

>>
>> +# Return an array with: a hash of remote names mapping to the corre=
sponding
>> +# remote heads, the value of the $limit parameter, and a boolean in=
dicating
>> +# whether we managed to get all the remotes or not.
>
> Perhaps it would be better to provide an example, rather than trying =
to
> describe the output.

I'm really not sure about how it would help, but I'll try.

>> +# If $limit is specified and the number of heads found is higher, t=
he head
>> +# list is empy. Additional filtering on the number of heads can be =
done when
>> +# displaying the remotes.
>> +sub git_get_remotes_data {
>> + =A0 =A0 my ($limit, $wanted) =3D @_;
>
> I'm not sure if it wouldn't be better to not worry git_get_remotes_da=
ta
> about $limit, but do limiting on output. =A0The amount of work gitweb
> needs to do in both situation is, I guess, nearly the same.

I think that the real issue is that situations in which gathering all
data and then discarding much of it would be very rare, being that it
would require a very large number of remotes (not remote heads, just
remotes). But considering that even I, a rather casual user, have at
least one project where the number of remotes is in the 20s, I
wouldn't be surprised if there were cases of humongous remote lists.

>> + =A0 =A0 my %remotes;
>> + =A0 =A0 open my $fd, '-|' , git_cmd(), 'remote', '-v';
>> + =A0 =A0 return unless $fd;
>> + =A0 =A0 my $more =3D 1;
>> + =A0 =A0 while (my $remote =3D <$fd> and $more) {
>
> Why not use 'last' instead of using $more variable (though I have not
> checked if it would really make code simpler and more readable).

Because we need to know whether we bail out early or not from the
loop. It might be appropriate to document this in the code.

>> + =A0 =A0 =A0 =A0 =A0 =A0 chomp $remote;
>> + =A0 =A0 =A0 =A0 =A0 =A0 $remote =3D~ s!\t(.*?)\s+\((\w+)\)$!!;
>> + =A0 =A0 =A0 =A0 =A0 =A0 next if $wanted and not $remote eq $wanted=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 my $url =3D $1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 my $key =3D $2;
>
> Minor nitpick: why not
>
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 my ($url, $key) =3D ($1, $2);

No reason. Can do.

>> + =A0 =A0 if ($more) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 my @heads =3D map { "remotes/$_" } keys %r=
emotes;
>> + =A0 =A0 =A0 =A0 =A0 =A0 my @remoteheads =3D git_get_heads_list(und=
ef, @heads);
>> + =A0 =A0 =A0 =A0 =A0 =A0 foreach (keys %remotes) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $remote =3D $_;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $remotes{$remote}{'heads'}=
 =3D [ grep {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $_->{'name=
'} =3D~ s!^$remote/!!
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } @remoteheads ];
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> + =A0 =A0 return (\%remotes, $limit, $more);
>
> Hmmmm... as it can be seen making this function do more work results
> in this ugly API. =A0If git_get_remotes_data didn't worry about limit=
ing,
> we could return simply %remotes hash (or \%remotes hash reference).

If I read your comments correctly, your idea would be to have two
separate functions, one that gets the list of remotes (with their
respective URLs), and a separate one (called when intended) to also
gather the list of heads. The only case in which the latter would not
be called would be when in summary view more than the given number of
maximum remotes were returned from the previous function. Correct?

>> +# Display a single remote block
>> +sub git_remote_body {
>> + =A0 =A0 my ($remote, $rdata, $limit, $head, $single) =3D @_;
>> + =A0 =A0 my %rdata =3D %{$rdata};
>
> Why do you need this, instead of simply using $rdata->{'heads'} etc.?

Because I keep getting messed up with the refs syntax in Perl. Thanks
for the hint.

>> + =A0 =A0 my $heads =3D $rdata{'heads'};
>
> Why not
>
> =A0+ =A0 =A0 my @heads =3D @{$rdata{'heads'}};
>
> Or
>
> =A0+ =A0 =A0 my @heads =3D @{$rdata->{'heads'}};
>
> without this strange '%rdata =3D %{$rdata};'

Well, the main use of heads was to be passed to git_heads_body so I
thought I would just leave it as a ref.

>> + =A0 =A0 if (defined $fetch) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ($fetch eq $push) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $urls .=3D git_repo_url("U=
RL", $fetch);
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $urls .=3D git_repo_url("F=
etch URL", $fetch);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $urls .=3D git_repo_url("P=
ush URL", $push) if defined $push;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 } elsif (defined $push) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 $urls .=3D git_repo_url("Push URL", $push)=
;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 $urls .=3D git_repo_url("", "No remote URL=
");
>> + =A0 =A0 }
>
> Perhaps reverse order of conditions would result in less nested
> conditional... but perhaps not.

I tried. The problem is that we just have that many cases (fetch and
no push, push and no fetch, equal fetch and push, different fetch and
push). I could not think of a way to handle them all in a more
streamlined way.

>> +
>> + =A0 =A0 $urls .=3D "</table>\n";
>> +
>> + =A0 =A0 my ($maxheads, $dots);
>> + =A0 =A0 if (defined $limit) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 $maxheads =3D $limit - 1;
>
> If git_get_remotes_data didn't do limiting, you could use
>
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 $maxheads =3D scalar @heads;
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ($#{$heads} > $maxheads) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $dots =3D $cgi->a({-href =3D=
> href(action=3D>"remotes", hash=3D>$remote)}, "...");
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>
> We can always check if we got more remotes than limit.
>

Actually, this is in reverse. get_remotes_data doesn't do limiting on
the number of heads, which is why $maxheads is $limit - 1 and the
number of heads is compared against it. git_remotes_data does limiting
on the number of _remotes_, and if the limit is hit, git_remote_body
would just not be called.

>> +
>> + =A0 =A0 my $content =3D sub {
>> + =A0 =A0 =A0 =A0 =A0 =A0 print $urls;
>> + =A0 =A0 =A0 =A0 =A0 =A0 git_heads_body($heads, $head, 0, $maxheads=
, $dots);
>> + =A0 =A0 };
>> +
>> + =A0 =A0 if (defined $single and $single) {
>
> 'defined $single and $single' is the same as '$single', because
> undefined value is false-ish.

I was over-protecting against warnings about the use of undefined
symbols. Cleaned up.

>> + =A0 =A0 =A0 =A0 =A0 =A0 $content->();
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 git_group("remotes", $remote, "remotes", $=
remote, $remote, $content);
>> + =A0 =A0 }
>
> Hmmm... should git_remote_body be responsible for wrapping in subsect=
ion?
> Wouldn't it be better to have caller use
>
> =A0git_group("remotes", $remote, "remotes", $remote, $remote,
> =A0 =A0 =A0 =A0 =A0 =A0sub { git_remote_body($remote, $rdata, $limit,=
 $head) });

Right.

> Sidenote: strange (but perhaps unavoidable) repetition we have here..=
=2E

Even with the new syntax discussed for the previous patches this is
unavoidable, it seems.

>> +}
>> +
>> +# Display remote heads grouped by remote, unless there are too many
>> +# remotes ($have_all is false), in which case we only display the r=
emote
>> +# names
>
> Wouldn't it be better to put displaying only remote names in a separa=
te
> subroutine, which would make git_remotes_body extremely simple?

Sure.

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "<td>" .
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $cgi->a({-href=
=3D> href(action=3D>'remotes', hash=3D>$remote),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0-class=3D> "list name"},esc_html($remote)) . "</td>";
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "<td class=3D\"link\=
">" .
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (defined $fetc=
h ? $cgi->a({-href=3D> $fetch}, "fetch") : "fetch") .
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " | " .
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (defined $push=
 ? $cgi->a({-href=3D> $push}, "push") : "push") .
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "</td>";
>
> I see that you don't worry here if $fetch =3D=3D $push, only if they
> are defined. =A0But I think it might be all right... though the exact
> output might need some discussion.

I'm open to suggestions.

>> =A0sub git_search_grep_body {
>> =A0 =A0 =A0 my ($commitlist, $from, $to, $extra) =3D @_;
>> =A0 =A0 =A0 $from =3D 0 unless defined $from;
>> @@ -5164,7 +5302,7 @@ sub git_summary {
>> =A0 =A0 =A0 # there are more ...
>> =A0 =A0 =A0 my @taglist =A0=3D git_get_tags_list(16);
>> =A0 =A0 =A0 my @headlist =3D git_get_heads_list(16, 'heads');
>> - =A0 =A0 my @remotelist =3D $remote_heads ? git_get_heads_list(16, =
'remotes') : ();
>> + =A0 =A0 my @remotelist =3D $remote_heads ? git_get_remotes_data(16=
) : ();
>
> That's not @remotelist any longer, isn't it?

Right. I renamed it to @remotedata across the whole file.

>> =A0 =A0 =A0 my @forklist;
>> =A0 =A0 =A0 my $check_forks =3D gitweb_check_feature('forks');
>>
>> @@ -5244,9 +5382,7 @@ sub git_summary {
>>
>> =A0 =A0 =A0 if (@remotelist) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 git_print_header_div('remotes');
>> - =A0 =A0 =A0 =A0 =A0 =A0 git_heads_body(\@remotelist, $head, 0, 15,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$#remotelis=
t <=3D 15 ? undef :
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$cgi->a({-h=
ref =3D> href(action=3D>"remotes")}, "..."));
>> + =A0 =A0 =A0 =A0 =A0 =A0 git_remotes_body(@remotelist, $head);
>
> Hmmm... (current API, with @remotelist (!) containing list of argumen=
ts
> to a subroutine).

It does make the call much cleaner though (think remotedata: it has
the data, and the information on whether the data is complete or not.
doesn't it make sense?)

>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 if (@forklist) {
>> @@ -5570,26 +5706,25 @@ sub git_remotes {
>> =A0 =A0 =A0 my $head =3D git_get_head_hash($project);
>> =A0 =A0 =A0 my $remote =3D $input_params{'hash'};
>>
>> + =A0 =A0 my @remotelist =3D git_get_remotes_data(undef, $remote);
>> + =A0 =A0 die_error(500, "Unable to get remote information") unless =
@remotelist;
>
> What if there are no remotes, and no remote-tracking branches?

Presently, we get 404 - No remotes found if there are no remotes. If
there are remotes without heads, the section will only contain the
URL.

The funny thing is that if there are no remotes there will be an empty
remotes section in summary view, so we probably to check for that too.

>> +
>> + =A0 =A0 if (keys(%{$remotelist[0]}) =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 die_error(404, defined $remote ?
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Remote $remote not found"=
 :
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "No remotes found");
>> + =A0 =A0 }
>
> Ah, I see that it is handled here. =A0Sidenote: with proposed changed
> API we can distinguish error case from no-remotes case by returning
> undefined value versus returning empty hash / empty hash reference.

The question is: do we really want the different API? It does make a
few things cleaner, but it makes other things messier (I'm thinking
here about the calls to git_*_body; compare what we have for remotes
with what we have for tags or heads list in summary view ...)

--=20
Giuseppe "Oblomov" Bilotta
